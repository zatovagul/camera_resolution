import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'camera_resolution_platform_interface.dart';

/// An implementation of [CameraResolutionPlatform] that uses method channels.
class MethodChannelCameraResolution extends CameraResolutionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('camera_resolution');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<List<Map<String, dynamic>>> getCameraInfo() async {
    final List<dynamic> cameras =
        await methodChannel.invokeMethod('getCameraInfo');
    return cameras.cast<Map<String, dynamic>>();
  }
}
