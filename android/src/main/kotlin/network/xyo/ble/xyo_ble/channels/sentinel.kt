package network.xyo.ble.xyo_ble.channels

import android.content.Context
import android.util.Log
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import network.xyo.ble.devices.XY4BluetoothDevice
import network.xyo.ble.devices.XYBluetoothDevice
import network.xyo.ble.devices.XYIBeaconBluetoothDevice
import network.xyo.ble.scanner.XYSmartScan
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
      else -> super.onMethodCall(call, result)
    }
  }

  override fun onStartAsync() = GlobalScope.async {
    smartScan.addListener("sentinel", object: XYSmartScan.Listener() {
      override fun statusChanged(status: XYSmartScan.Status) {
        Log.i("sentinel", "statusChanged: ${status}")
        super.statusChanged(status)
      }

      override fun detected(device: XYBluetoothDevice) {
        Log.i("sentinel", "detected")
        super.detected(device)
      }
    })
    if (smartScan.start().await()) {
      return@async STATUS_STARTED
    } else {
      return@async STATUS_STOPPED
    }
  }

  override fun onStopAsync() = GlobalScope.async {
    smartScan.removeListener("sentinel")
    if (smartScan.stop().await()) {
      return@async STATUS_STOPPED
    } else {
      return@async STATUS_STARTED
    }
  }
}