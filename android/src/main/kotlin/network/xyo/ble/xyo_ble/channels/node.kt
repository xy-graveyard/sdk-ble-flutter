package network.xyo.ble.xyo_ble.channels

import android.content.Context
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import network.xyo.ble.xyo_ble.BridgeManager

open class XyoNodeChannel(context: Context, registrar: PluginRegistry.Registrar, name: String): XyoBaseChannel(registrar, name) {

  protected val bridgeManager = BridgeManager(context)

  override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
    when (call.method) {
      "getPublicKey" -> getPublicKey(call, result)
      else -> super.onMethodCall(call, result)
    }
  }

  private fun getPublicKey(call: MethodCall, result: MethodChannel.Result) = GlobalScope.launch {
    sendResult(result, bridgeManager.getPrimaryPublicKeyAsString())
  }
}