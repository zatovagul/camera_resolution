import 'camera_resolution_platform_interface.dart';

class CameraResolution {
  Future<String?> getPlatformVersion() {
    return CameraResolutionPlatform.instance.getPlatformVersion();
  }

  Future<List<Map<String, dynamic>>> getCameraInfo() {
    return CameraResolutionPlatform.instance.getCameraInfo();
  }
}
