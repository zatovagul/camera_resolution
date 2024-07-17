import Flutter
import UIKit
import AVFoundation

public class CameraResolutionPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "camera_resolution", binaryMessenger: registrar.messenger())
    let instance = CameraResolutionPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "getPlatformVersion":
            result("iOS " + UIDevice.current.systemVersion)
        case "getCameraInfo":
            result(getCameraInfo())
        default:
            result(FlutterMethodNotImplemented)
    }
  }

   private func getCameraInfo() -> [[String: Any]] {
           var cameras = [[String: Any]]()

           let deviceTypes: [AVCaptureDevice.DeviceType] = {
               if #available(iOS 13.0, *) {
                   return [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDualCamera, .builtInDualWideCamera, .builtInUltraWideCamera]
               } else {
                   return [.builtInWideAngleCamera, .builtInTelephotoCamera, .builtInDualCamera]
               }
           }()

           let discoverySession = AVCaptureDevice.DiscoverySession(
               deviceTypes: deviceTypes,
               mediaType: .video,
               position: .unspecified
           )

           for device in discoverySession.devices {
               var cameraInfo = [String: Any]()
               cameraInfo["localizedName"] = device.localizedName
               cameraInfo["facingMode"] = facingModeString(for: device.position)

               let formats = device.formats
               var resolutions = [[String: Int]]()
               for format in formats {
                   let description = format.formatDescription
                   let dimensions = CMVideoFormatDescriptionGetDimensions(description)
                   let resolution = ["width": Int(dimensions.width), "height": Int(dimensions.height)]
                   resolutions.append(resolution)
               }
               cameraInfo["resolutions"] = resolutions

               cameras.append(cameraInfo)
           }

           return cameras
       }

      private func facingModeString(for position: AVCaptureDevice.Position) -> String {
          switch position {
          case .front:
              return "front"
          case .back:
              return "back"
          default:
              return "unknown"
          }
      }
}
