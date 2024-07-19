import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'camera_resolution_platform_interface.dart';

/// An implementation of [CameraResolutionPlatform] that uses method channels.
class MethodChannelCameraResolution extends CameraResolutionPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('camera_resolution');

  @override
  Future<List<Map<String, dynamic>>> getCameraInfo() async {
    final List<dynamic> cameras =
        await methodChannel.invokeMethod('getCameraInfo');
    return compute(
      (value) =>
          value.map((camera) => _convertToMapStringDynamic(camera)).toList(),
      cameras,
    );
  }

  Map<String, dynamic> _convertToMapStringDynamic(
    Map<dynamic, dynamic> original,
  ) {
    final result = <String, dynamic>{};
    original.forEach((key, value) {
      result[key.toString()] = _convertValue(value);
    });
    return result;
  }

  dynamic _convertValue(dynamic value) {
    if (value is Map) {
      return _convertToMapStringDynamic(value);
    } else if (value is List) {
      return value.map((item) => _convertValue(item)).toList();
    } else {
      return value;
    }
  }
}
