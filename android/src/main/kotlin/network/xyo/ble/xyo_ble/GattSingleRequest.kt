package network.xyo.ble.xyo_ble

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import network.xyo.ble.scanner.XYSmartScan

class GattSingleRequest: GattRequestHandler() {

    companion object {
        fun process(smartScan: XYSmartScan, arguments: Any?, result: MethodChannel.Result): Deferred<Boolean> {
            return GlobalScope.async {
                val operation = operation(arguments) ?: return@async false
                val device = smartScan.devices[operation.deviceId] ?: return@async false

                val response: Gatt.GattResponse?
                val bleResult = device.connection {
                    return@connection runCall(device, operation)
                }.await()
                response = response(operation, bleResult)
                relayResponse(response, result)
                cleanup(device, operation)
                return@async true
            }
        }
    }
}
