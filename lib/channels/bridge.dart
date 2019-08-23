import 'package:flutter/services.dart';
import 'package:sdk_ble_flutter/channels/node.dart';
import 'package:sdk_ble_flutter/classes/archivist.dart';
import 'package:sdk_ble_flutter/main.dart';

class XyoBridgeChannel extends XyoNodeChannel {

  final EventChannel events;

  XyoBridgeChannel(String name) : events = EventChannel(name), super(name);

  // Set the archivists
  Future<bool> setArchivists(List<ArchivistModel> archivists) async {
    final List<Map<String, dynamic>> values =
        archivists.map((a) => {'dns': a.dns, 'port': a.port}).toList();

    return await invokeMethod('setArchivists', <String, dynamic>{
      'archivists': values,
    });
  }

  // Self Sign a Block
  Future<DeviceBoundWitness> selfSign() async {
    return DeviceBoundWitness.fromBuffer(await invokeMethod('selfSign'));
  }
}
