import 'dart:async';

import 'package:flutter/services.dart' show MethodChannel;
import 'package:flutter/services.dart';

export 'package:sdk_ble_flutter/protos/gatt.pb.dart';

export 'package:sdk_ble_flutter/protos/device.pb.dart';

import 'package:sdk_ble_flutter/classes/archivist.dart';
import 'package:sdk_ble_flutter/entrypoints/device.dart';

export 'package:sdk_ble_flutter/protos/bound_witness.pb.dart';

class XyoSdk {
  static final MethodChannel _channel =
      const MethodChannel('network.xyo/sdk');

  static final EventChannel smartScanEventChannel =
      const EventChannel('network.xyo/smartscan');

  static final EventChannel boundWitnessEventChannel =
      const EventChannel('network.xyo/boundwitness');

  static final EventChannel addDevice =
      const EventChannel('network.xyo/add_device');

  static final XyoDevice device = new XyoDevice(_channel);

  // Set the archivists
  static Future<bool> setArchivists(List<ArchivistModel> archivists) async {
    final List<Map<String, dynamic>> values =
        archivists.map((a) => {'dns': a.dns, 'port': a.port}).toList();

    return await _channel.invokeMethod('setArchivists', <String, dynamic>{
      'archivists': values,
    });
  }

  // Start collecting bound witness data
  static Future<bool> startBoundWitness() async {
    return await _channel.invokeMethod('startBoundWitness');
  }

  // Stop collecting bound witness data
  static Future<bool> stopBoundWitness() async {
    return await _channel.invokeMethod('stopBoundWitness');
  }

  // Start listening for button presses on devices
  static Future<bool> startAddDevice() async {
    return await _channel.invokeMethod('addDeviceStartListening');
  }

  // Stop listening for button presses on devices
  static Future<bool> stopAddDevice() async {
    return await _channel.invokeMethod('addDeviceStopListening');
  }

  // Start running as a central (listening)
  static Future<bool> startScanner() async {
    return await _channel.invokeMethod('startScanner');
  }

  // Stop running as a central (listening)
  static Future<bool> stopScanner() async {
    return await _channel.invokeMethod('stopScanner');
  }

  // Start running as a peripheral (advertising)
  static Future<bool> startServer() async {
    return await _channel.invokeMethod('startServer');
  }

  // Stop running as a peripheral (advertising)
  static Future<bool> stopServer() async {
    return await _channel.invokeMethod('stopServer');
  }

  // Get the device public key
  static Future<String> getDevicePublicKey() async {
    return await _channel.invokeMethod('getDevicePublicKey');
  }

  // Get blockCount
  static Future<int> getBlockCount() async {
    return await _channel.invokeMethod('getBlockCount');
  }

  // Get block by Index
  static Future<String> getBlockByIndex() async {
    return await _channel.invokeMethod('getBlockByIndex');
  }

  // Self Sign a Block
  static Future<String> selfsign() async {
    return await _channel.invokeMethod('selfsign');
  }

}
