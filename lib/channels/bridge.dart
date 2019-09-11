import 'package:sdk_ble_flutter/channels/node.dart';
import 'package:sdk_ble_flutter/classes/archivist.dart';
import 'package:sdk_ble_flutter/main.dart';

typedef XyoStatusUpdatedCallback = void Function(String);

enum status { none, enabled, bluetoothDisabled, bluetoothUnavailable, locationDisabled }

//final stringToStatus()

class XyoBridgeChannel extends XyoNodeChannel {
  XyoBridgeChannel(String name) : super(name);

  Map<String, XyoStatusUpdatedCallback> onStatusUpdatedNotify = Map();

  void reportStatusUpdate(dynamic status) {
    //final bluetoothDevice = BluetoothDevice.fromBuffer(device);
    //onStatusUpdatedNotify.forEach((String key, XyoStatusUpdatedCallback callback) => callback(status));
  }

  Future<String> getStatus() async {
    return await invokeMethod('getStatus');
  }

  // Set the archivists
  Future<bool> setArchivists(List<ArchivistModel> archivists) async {
    final List<Map<String, dynamic>> values = archivists.map((a) => {'dns': a.dns, 'port': a.port}).toList();

    return await invokeMethod('setArchivists', <String, dynamic>{
      'archivists': values,
    });
  }

  // Self Sign a Block
  Future<DeviceBoundWitness> selfSign() async {
    return DeviceBoundWitness.fromBuffer(await invokeMethod('selfSign'));
  }
}
