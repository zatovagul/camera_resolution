import 'package:camera_resolution/models.dart';

import 'camera_resolution_platform_interface.dart';

class CameraResolution {
  static Future<List<Map<String, dynamic>>> getCameraInfo() {
    return CameraResolutionPlatform.instance.getCameraInfo();
  }

  static Future<List<MediaDeviceInfo>> getDevices() async {
    final list = await getCameraInfo();
    return list.map<MediaDeviceInfo>((e) {
      final r = MediaDeviceInfo.fromJson(e);
      return r;
    }).toList();
  }
}
