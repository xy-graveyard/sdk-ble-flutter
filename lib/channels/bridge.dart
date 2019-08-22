import 'package:flutter/services.dart';
import 'package:sdk_ble_flutter/channels/node.dart';
import 'package:sdk_ble_flutter/classes/archivist.dart';

class XyoBridgeChannel extends XyoNodeChannel {

  final EventChannel events;

  XyoBridgeChannel(String name) : events = EventChannel(name), super(name);

  // Start running as a central (listening)
  Future<bool> start() async {
    return await invokeMethod('start');
  }

  // Stop running as a central (listening)
  Future<bool> stop() async {
    return await invokeMethod('stop');
  }

  // Set the archivists
  Future<bool> setArchivists(List<ArchivistModel> archivists) async {
    final List<Map<String, dynamic>> values =
        archivists.map((a) => {'dns': a.dns, 'port': a.port}).toList();

    return await invokeMethod('setArchivists', <String, dynamic>{
      'archivists': values,
    });
  }
}
