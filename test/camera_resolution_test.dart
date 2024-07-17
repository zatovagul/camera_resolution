import 'package:flutter_test/flutter_test.dart';
import 'package:camera_resolution/camera_resolution.dart';
import 'package:camera_resolution/camera_resolution_platform_interface.dart';
import 'package:camera_resolution/camera_resolution_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCameraResolutionPlatform
    with MockPlatformInterfaceMixin
    implements CameraResolutionPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<List<Map<String, dynamic>>> getCameraInfo() {
    // TODO: implement getCameraInfo
    throw UnimplementedError();
  }
}

void main() {
  final CameraResolutionPlatform initialPlatform = CameraResolutionPlatform.instance;

  test('$MethodChannelCameraResolution is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCameraResolution>());
  });

  test('getPlatformVersion', () async {
    CameraResolution cameraResolutionPlugin = CameraResolution();
    MockCameraResolutionPlatform fakePlatform = MockCameraResolutionPlatform();
    CameraResolutionPlatform.instance = fakePlatform;

    expect(await cameraResolutionPlugin.getPlatformVersion(), '42');
  });
}
