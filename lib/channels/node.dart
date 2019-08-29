import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sdk_ble_flutter/protos/bound_witness.pb.dart';

typedef XyoNodeUpdatedCallback = void Function(XyoNodeChannel);

class XyoNodeChannel extends MethodChannel {
  final EventChannel events;

  XyoNodeChannel(String name)
      : events = EventChannel("${name}Events"),
        super(name) {
    events.receiveBroadcastStream().listen(reportUpdated);
  }

  Map<String, XyoNodeUpdatedCallback> onUpdated = Map();

  void reportUpdated(dynamic) {
    onUpdated.forEach(
        (String key, XyoNodeUpdatedCallback callback) => callback(this));
  }

  Future<String> start() async {
    return invokeMethod<String>('start');
  }

  Future<String> stop() async {
    return invokeMethod<String>('stop');
  }

  Future<String> get status async {
    return invokeMethod<String>('getStatus');
  }

  // Get the device public key
  Future<String> get publicKey async {
    return invokeMethod<String>('getPublicKey');
  }

  // Get blockCount
  Future<int> get blockCount async {
    return invokeMethod<int>('getBlockCount');
  }

  // Get block by Index
  Future<DeviceBoundWitness> get lastBlock async {
    return DeviceBoundWitness.fromBuffer(await invokeMethod('getLastBlock'));
  }
}
