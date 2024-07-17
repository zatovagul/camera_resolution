package com.mobsolutions.camera_resolution.camera_resolution

import androidx.annotation.NonNull
import android.content.Context
import android.hardware.camera2.CameraAccessException
import android.hardware.camera2.CameraCharacteristics
import android.hardware.camera2.CameraManager
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** CameraResolutionPlugin */
class CameraResolutionPlugin : FlutterPlugin, MethodCallHandler {
    ///
    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "camera_resolution")
        channel.setMethodCallHandler(this)
        applicationContext = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" -> result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "getCameraInfo" -> result.success(getCameraInfo())
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun getCameraInfo(): List<Map<String, Any>> {
        val cameras = mutableListOf<Map<String, Any>>()
        val cameraManager = applicationContext.getSystemService(Context.CAMERA_SERVICE) as CameraManager
        try {
            for (cameraId in cameraManager.cameraIdList) {
                val characteristics = cameraManager.getCameraCharacteristics(cameraId)
                val cameraInfo = mutableMapOf<String, Any>()
                cameraInfo["cameraId"] = cameraId
                val lensFacing = characteristics.get(CameraCharacteristics.LENS_FACING)
                cameraInfo["lensFacing"] = when (lensFacing) {
                    CameraCharacteristics.LENS_FACING_FRONT -> "front"
                    CameraCharacteristics.LENS_FACING_BACK -> "back"
                    else -> "unknown"
                }
                cameraInfo["sensorOrientation"] = characteristics.get(CameraCharacteristics.SENSOR_ORIENTATION) ?: -1

                // Получение списка поддерживаемых размеров
                val map = characteristics.get(CameraCharacteristics.SCALER_STREAM_CONFIGURATION_MAP)
                val sizes = map?.getOutputSizes(android.graphics.ImageFormat.JPEG)
                val resolutions = sizes?.map { size -> mapOf("width" to size.width, "height" to size.height) }
                    ?: emptyList<Map<String, Int>>()
                cameraInfo["resolutions"] = resolutions

                cameras.add(cameraInfo)
            }
        } catch (e: CameraAccessException) {
            e.printStackTrace()
        }
        return cameras
    }
}
