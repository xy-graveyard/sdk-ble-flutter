import 'package:flutter/services.dart';
import 'package:sdk_ble_flutter/protos/bound_witness.pb.dart';

class XyoNodeChannel extends MethodChannel {

  final EventChannel events;

  XyoNodeChannel(String name) : events = EventChannel(name), super(name);

  // Get the device public key
  Future<String> get publicKey async {
    return await invokeMethod<String>('getPublicKey');
  }

  // Get blockCount
  Future<int> get blockCount async {
    return await invokeMethod<int>('getBlockCount');
  }

  // Get block by Index
  Future<DeviceBoundWitness> get lastBlock async {
    return DeviceBoundWitness.fromBuffer(await invokeMethod('getLastBlock'));
  }
}
