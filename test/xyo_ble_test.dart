import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sdk_ble_flutter/xyo_ble.dart';

void main() {
  const MethodChannel channel = MethodChannel('xyo_ble');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await XyoBle.platformVersion, '42');
  });
}
