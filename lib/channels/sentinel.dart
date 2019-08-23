import 'package:flutter/services.dart';
import 'package:sdk_ble_flutter/channels/node.dart';

class XyoSentinelChannel extends XyoNodeChannel {

  final EventChannel events;

  XyoSentinelChannel(String name) : events = EventChannel(name), super(name);

}
