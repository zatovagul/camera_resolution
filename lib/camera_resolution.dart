import 'package:camera_resolution/models.dart';

import 'camera_resolution_platform_interface.dart';

class CameraResolution {
  Future<String?> getPlatformVersion() {
    return CameraResolutionPlatform.instance.getPlatformVersion();
  }

  Future<List<Map<String, dynamic>>> getCameraInfo() {
    return CameraResolutionPlatform.instance.getCameraInfo();
  }

  Future<List<MediaDeviceInfo>> getDevices() async {
    final list = await getCameraInfo();

    for(var i in list){
      print(i);
    }
    return list.map<MediaDeviceInfo>((e) {
      final r = MediaDeviceInfo.fromJson(e);
      return r;
    }).toList();
  }
}
