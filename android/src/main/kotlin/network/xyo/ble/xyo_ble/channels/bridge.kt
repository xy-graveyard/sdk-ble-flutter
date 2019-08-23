package network.xyo.ble.xyo_ble.channels

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import network.xyo.ble.devices.XY4BluetoothDevice
import network.xyo.ble.devices.XYIBeaconBluetoothDevice
import network.xyo.ble.flutter.protobuf.BoundWitness
import network.xyo.ble.gatt.server.XYBluetoothGattServer
import network.xyo.ble.scanner.XYSmartScanModern
import network.xyo.ble.xyo_ble.InteractionModel
import network.xyo.modbluetoothkotlin.client.XyoBluetoothClient
import network.xyo.modbluetoothkotlin.client.XyoSentinelX
import network.xyo.modbluetoothkotlin.server.XyoBluetoothServer
import network.xyo.sdkcorekotlin.boundWitness.XyoBoundWitness
import network.xyo.sdkcorekotlin.node.XyoNodeListener
import network.xyo.sdkobjectmodelkotlin.structure.XyoObjectStructure
import java.io.PrintWriter
import java.io.StringWriter
import java.io.UnsupportedEncodingException
import java.lang.Exception
import java.util.*
import kotlin.collections.ArrayList

@kotlin.ExperimentalUnsignedTypes
class XyoBridgeChannel(context: Context, registrar: PluginRegistry.Registrar, name: String): XyoNodeChannel(context, registrar, name) {

  private val smartScan = XYSmartScanModern(context.applicationContext)
  private val server = XYBluetoothGattServer(context.applicationContext)
  private val serverHelper = XyoBluetoothServer(server)

  init {
    GlobalScope.launch {
      bridgeManager.restoreAndInitBridge().await()
      bridgeManager.bridge.addListener("flutter_entry", onBoundWitness)
    }

    XYIBeaconBluetoothDevice.enable(true)
    XyoBluetoothClient.enable(true)
    XyoSentinelX.enable(true)
    XY4BluetoothDevice.enable(true)
  }

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
      when (call.method) {
        "start" -> start(call, result)
        "stop" -> stop(call, result)
        "setArchivists" -> setArchivists(call, result)
        "getBlockCount" -> getBlockCount(call, result)
        "getLastBlock" -> getLastBlock(call, result)
        else -> super.onMethodCall(call, result)
      }
  }

  private fun start(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    smartScan.addListener("flutter_entry_scan", bridgeManager.bridge.scanCallback)
    serverHelper.listener = bridgeManager.bridge.serverCallback
    sendResult(result, smartScan.start().await() && server.startServer())
  }

  private fun stop(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    smartScan.removeListener("flutter_entry_scan")
    serverHelper.listener = null
    server.stopServer()
    sendResult(result, smartScan.stop().await())
  }

  private fun setArchivists(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    notImplemented(result)
  }

  private fun getBlockCount(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
      val hashes = bridgeManager.bridge.blockRepository.getAllOriginBlockHashes().await() ?: return@launch sendError(result, "FAILED")
      val models = hashesToBoundWitnesses(hashes)

      sendResult(result, models.count())
  }

  private fun getLastBlock(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
      val hashes = bridgeManager.bridge.blockRepository.getAllOriginBlockHashes().await() ?: return@launch sendError(result, "FAILED")
      val models = hashesToBoundWitnesses(hashes)
      val count = models.count()

      if (count > 0) {
        var lastModel = models[count - 1]
        sendResult(result, lastModel.toByteArray())
      } else {
        sendResult(result, null)
      }
  }

  private fun hashesToBoundWitnesses(hashes: Iterator<XyoObjectStructure>): ArrayList<BoundWitness.DeviceBoundWitness> {
    val models = ArrayList<BoundWitness.DeviceBoundWitness>()

    for (hash in hashes) {
      val model = InteractionModel(bridgeManager.bridge.blockRepository, hash.bytesCopy, Date(), true)
      models.add(model.toBuffer())
    }

    return models
  }

  private fun notifyNewBoundWitness() {
    GlobalScope.launch {
      val hashes = bridgeManager.bridge.blockRepository.getAllOriginBlockHashes().await()
              ?: return@launch
      val models = hashesToBoundWitnesses(hashes)

      events.send(models.toTypedArray())
    }
  }

  private val onBoundWitness = object : XyoNodeListener() {
    override fun onBoundWitnessEndSuccess(boundWitness: XyoBoundWitness) {
      notifyNewBoundWitness();
    }
  }
}