package network.xyo.ble.xyo_ble.channels

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import network.xyo.ble.xyo_ble.BridgeManager

open class XyoNodeChannel(context: Context, registrar: PluginRegistry.Registrar, name: String): XyoBaseChannel(registrar, name) {

  protected val bridgeManager = BridgeManager(context)
  protected var status = STATUS_STOPPED

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "start" -> start(call, result)
      "stop" -> stop(call, result)
      "getPublicKey" -> getPublicKey(call, result)
      "getStatus" -> getStatus(call, result)
      else -> super.onMethodCall(call, result)
    }
  }

  //this should return the new running state
  open fun onStartAsync() = GlobalScope.async {
    return@async STATUS_STARTED
  }

  //this should return the new running state
  open fun onStopAsync() = GlobalScope.async {
    return@async STATUS_STOPPED
  }

  private fun getStatus(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, status)
  }

  private fun start(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    status = onStartAsync().await()
    sendResult(result, status)
  }

  private fun stop(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    status = onStopAsync().await()
    sendResult(result, status)
  }

  private fun getPublicKey(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, bridgeManager.getPrimaryPublicKeyAsString())
  }

  companion object {
    const val STATUS_STARTED = "started"
    const val STATUS_STOPPED = "stopped"
  }
}