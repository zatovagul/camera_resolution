import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'camera_resolution_method_channel.dart';

abstract class CameraResolutionPlatform extends PlatformInterface {
  /// Constructs a CameraResolutionPlatform.
  CameraResolutionPlatform() : super(token: _token);

  static final Object _token = Object();

  static CameraResolutionPlatform _instance = MethodChannelCameraResolution();

  /// The default instance of [CameraResolutionPlatform] to use.
  ///
  /// Defaults to [MethodChannelCameraResolution].
  static CameraResolutionPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [CameraResolutionPlatform] when
  /// they register themselves.
  static set instance(CameraResolutionPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<Map<String, dynamic>>> getCameraInfo() {
    throw UnimplementedError('getCameraInfo() has not been implemented.');
  }
}
