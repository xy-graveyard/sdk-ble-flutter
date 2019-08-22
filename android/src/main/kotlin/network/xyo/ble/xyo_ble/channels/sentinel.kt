package network.xyo.ble.xyo_ble.channels

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import network.xyo.ble.devices.XY4BluetoothDevice
import network.xyo.ble.devices.XYIBeaconBluetoothDevice
import network.xyo.ble.scanner.XYSmartScanModern
import network.xyo.modbluetoothkotlin.client.XyoBluetoothClient
import network.xyo.modbluetoothkotlin.client.XyoSentinelX

class XyoSentinelChannel(context: Context, registrar: PluginRegistry.Registrar, name: String): XyoNodeChannel(context, registrar, name) {

  private val smartScan = XYSmartScanModern(context.applicationContext)

  init {
    XYIBeaconBluetoothDevice.enable(true)
    XyoBluetoothClient.enable(true)
    XyoSentinelX.enable(true)
    XY4BluetoothDevice.enable(true)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "start" -> start(call, result)
      "stop" -> stop(call, result)
      else -> super.onMethodCall(call, result)
    }
  }

  private fun start(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, smartScan.start().await())
  }

  private fun stop(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, smartScan.stop().await())
  }
}