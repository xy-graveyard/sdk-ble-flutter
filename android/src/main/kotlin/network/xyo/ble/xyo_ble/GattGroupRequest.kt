package network.xyo.ble.xyo_ble

import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import network.xyo.ble.gatt.peripheral.IXYBluetoothResult
import network.xyo.ble.gatt.peripheral.XYBluetoothResult
import network.xyo.ble.scanner.XYSmartScan

class GattGroupRequest: GattRequestHandler() {

    companion object {
        fun process(smartScan: XYSmartScan, arguments: Any?, result: MethodChannel.Result): Deferred<Boolean> {
            return GlobalScope.async {
                val operations = operations(arguments) ?: return@async false
                val responses = execute(smartScan, operations).await() ?: return@async false
                val responseListBuilder = Gatt.GattResponseList.newBuilder()
                for (response: Gatt.GattResponse in responses) {
                    responseListBuilder.addResponses(response)
                }
                relayResponse(responseListBuilder.build(), result)
                return@async true
            }
        }

        fun execute(smartScan: XYSmartScan, operations: Gatt.GattOperationList): Deferred<List<Gatt.GattResponse>?> {
            return GlobalScope.async {
                val responses = mutableListOf<Gatt.GattResponse>()
                for (operation in operations.operationsList) {
                    val device = smartScan.devices[operation.deviceId] ?: return@async null
                    device.connection {
                        val result = runCall(device, operation).await()
                        responses.add(response(operation, result))
                        return@connection XYBluetoothResult(true)
                    }.await()
                }
                return@async responses
            }
        }
    }

}
