import 'package:flutter/services.dart';
import 'package:sdk_ble_flutter/channels/node.dart';

class XyoSentinelChannel extends XyoNodeChannel {

  final EventChannel events;

  XyoSentinelChannel(String name) : events = EventChannel(name), super(name);

  // Start running as a central (listening)
  Future<bool> start() async {
    return await invokeMethod('start');
  }

  // Stop running as a central (listening)
  Future<bool> stop() async {
    return await invokeMethod('stop');
  }

  // Self Sign a Block
  Future<String> selfsign() async {
    return await invokeMethod('selfsign');
  }
}
