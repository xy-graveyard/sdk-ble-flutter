import 'package:flutter/services.dart';

class XyoNodeChannel extends MethodChannel {

  final EventChannel events;

  XyoNodeChannel(String name) : events = EventChannel(name), super(name);

  // Get the device public key
  Future<String> get publicKey async {
    return await invokeMethod<String>('getPublicKey');
  }

  // Get blockCount
  Future<int> get blockCount async {
    return await invokeMethod('getBlockCount');
  }

  // Get block by Index
  Future<String> get blockByIndex async {
    return await invokeMethod('getBlockByIndex');
  }
}
