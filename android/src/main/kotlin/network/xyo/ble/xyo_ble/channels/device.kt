package network.xyo.ble.xyo_ble.channels

import android.content.Context
import io.flutter.plugin.common.*
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import network.xyo.ble.devices.XY4BluetoothDevice
import network.xyo.ble.devices.XYBluetoothDevice
import network.xyo.ble.devices.XYIBeaconBluetoothDevice
import network.xyo.ble.flutter.protobuf.BoundWitness
import network.xyo.ble.scanner.XYSmartScan
import network.xyo.ble.scanner.XYSmartScanModern
import network.xyo.ble.xyo_ble.GattGroupRequest
import network.xyo.ble.xyo_ble.GattSingleRequest
import network.xyo.ble.xyo_ble.ui
import network.xyo.modbluetoothkotlin.client.XyoBluetoothClient
import network.xyo.modbluetoothkotlin.client.XyoSentinelX

class XyoDeviceChannel(context: Context, registrar: PluginRegistry.Registrar, name: String): XyoBaseChannel(registrar, name) {

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
      "gattSingle" -> gattSingle(call, result)
      "gattGroup" -> gattGroup(call, result)
      "gattList" -> gattList(call, result)
      else -> super.onMethodCall(call, result)
    }
  }

  private fun start(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, true)
  }

  private fun stop(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, true)
  }

  private fun gattSingle(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result,GattSingleRequest.process(smartScan, call.arguments, result))
  }

  private fun gattGroup(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result,GattGroupRequest.process(smartScan, call.arguments, result))
  }

  private fun gattList(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result,GattGroupRequest.process(smartScan, call.arguments, result))
  }

  private val streamHandler = object: EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(args: Any?, eventSink: EventChannel.EventSink?) {
      this.eventSink = eventSink
    }

    override fun onCancel(args: Any?) {
      this.eventSink = null
    }

    fun sendMessage(boundWitnesses: Array<BoundWitness.DeviceBoundWitness>) {
      val builder = BoundWitness.DeviceBoundWitnessList.newBuilder()

      builder.addAllBoundWitnesses(boundWitnesses.toList())

      ui {
        eventSink?.success(builder.build().toByteArray())
      }
    }
  }

  private val listener = object: XYSmartScan.Listener() {
    override fun statusChanged(status: XYSmartScan.Status) {
      super.statusChanged(status)
    }

    override fun connectionStateChanged(device: XYBluetoothDevice, newState: Int) {
      super.connectionStateChanged(device, newState)
    }

    override fun detected(device: XYBluetoothDevice) {
      events.send(device)
      super.detected(device)
    }

    override fun entered(device: XYBluetoothDevice) {
      events.send(device)
      super.entered(device)
    }

    override fun exited(device: XYBluetoothDevice) {
      super.exited(device)
    }
  }
}