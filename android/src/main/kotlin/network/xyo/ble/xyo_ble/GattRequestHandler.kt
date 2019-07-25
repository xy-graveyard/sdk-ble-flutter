package network.xyo.ble.xyo_ble

import com.google.protobuf.ByteString
import io.flutter.plugin.common.MethodChannel
import network.xyo.ble.devices.XYBluetoothDevice
import network.xyo.ble.devices.XYIBeaconBluetoothDevice
import network.xyo.ble.gatt.peripheral.XYBluetoothResult
import network.xyo.ble.gatt.server.XYBluetoothCharacteristic
import network.xyo.ble.gatt.server.XYBluetoothService
import network.xyo.ble.services.standard.AlertNotificationService
import java.nio.charset.Charset

open class GattRequestHandler {

    companion object {

        fun argsAsDict(arguments: Any?): Map<String, Any?>? {
            return arguments as? Map<String, Any?>
        }

        fun operations(arguments: Any?): Gatt.GattOperationList? {
            val args = this.argsAsDict(arguments)
            val data = args?.get("request") as? ByteArray ?: return null
            return Gatt.GattOperationList.parseFrom(data)
        }

        // Used to unpack a single gatt request
        fun operation(arguments: Any?): Gatt.GattOperation? {
            val args = this.argsAsDict(arguments)
            val data = args?.get("request") as? ByteArray ?: return null
            return Gatt.GattOperation.parseFrom(data)
        }

        // Build a success response that has data
        fun response(request: Gatt.GattOperation, response: XYBluetoothResult<Any>?): Gatt.GattResponse {
            val result = Gatt.GattResponse.newBuilder()
                    .setDeviceId(request.deviceId)
                    .setGattCall(request.gattCall)
                    .setResponse(ByteString.copyFrom(response?.value.toString(), Charset.defaultCharset()))
            if (response?.error != null) {
                result.setError(response.error.toString())
            }
            return result.build()
        }

        // Used when the request fails in the catch
        fun response(request: Gatt.GattOperation, error: Error): Gatt.GattResponse {
            val result = Gatt.GattResponse.newBuilder()
                    .setDeviceId(request.deviceId)
                    .setGattCall(request.gattCall)
                    .setError(error.message)
            return result.build()
        }

        // Make the gatt call
        fun runCall(device: XYBluetoothDevice, operation: Gatt.GattOperation): XYBluetoothResult<Any> {
            when(operation.operationCase) {
                Gatt.GattOperation.OperationCase.GATT_CALL -> {
                }
                Gatt.GattOperation.OperationCase.DEFINED_OPERATION -> {
                }
                Gatt.GattOperation.OperationCase.OPERATION_NOT_SET -> {

                }
                else -> {

                }
            }
            val bleResult = XYBluetoothResult<Any>(null)
            return bleResult
        }

        fun relayResponse(response: Gatt.GattResponse?, result: MethodChannel.Result) {
            result.success(response)
        }

        fun relayResponse(responses: Gatt.GattResponseList?, result: MethodChannel.Result) {
            result.success(responses)
        }

        fun cleanup(device: XYBluetoothDevice, operation: Gatt.GattOperation) {
            if (operation.disconnectOnCompletion) {
                device.disconnect()
            }
        }

        fun cleanup(device: XYBluetoothDevice, operations: Gatt.GattOperationList) {
            if (operations.disconnectOnCompletion) {
                device.disconnect()
            }
        }
    }
}
