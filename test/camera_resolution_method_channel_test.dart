import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:camera_resolution/camera_resolution_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelCameraResolution platform = MethodChannelCameraResolution();
  const MethodChannel channel = MethodChannel('camera_resolution');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {});
}
