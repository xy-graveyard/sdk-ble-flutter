package network.xyo.ble.xyo_ble

import kotlinx.coroutines.Deferred
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.async
import network.xyo.ble.devices.XYBluetoothDevice
import network.xyo.ble.devices.XYFinderBluetoothDevice
import network.xyo.ble.flutter.protobuf.Gatt
import network.xyo.ble.gatt.peripheral.IXYBluetoothResult
import network.xyo.ble.gatt.peripheral.XYBluetoothResult
import network.xyo.modbluetoothkotlin.client.XyoSentinelX

class GattDefinedOperationHandler {

    companion object {
        // Run the operations
        @kotlin.ExperimentalUnsignedTypes
        fun process(device: XYBluetoothDevice, operation: Gatt.DefinedOperation): Deferred<IXYBluetoothResult?> {
            return GlobalScope.async {
                val finder = device as? XYFinderBluetoothDevice
                val sentinelX = device as? XyoSentinelX
                var result: IXYBluetoothResult? = null
                device.connection {
                    when (operation) {
                        Gatt.DefinedOperation.SONG -> {
                            finder?.unlock()?.await()
                            result = finder?.find()?.await()
                        }
                        Gatt.DefinedOperation.STOP_SONG -> {
                            finder?.unlock()?.await()
                            result = finder?.stopFind()?.await()
                        }
                        Gatt.DefinedOperation.STAY_AWAKE -> {
                            finder?.unlock()?.await()
                            result = finder?.stayAwake()?.await()
                        }
                        Gatt.DefinedOperation.GO_TO_SLEEP -> {
                            finder?.unlock()?.await()
                            result = finder?.fallAsleep()?.await()
                        }
                        Gatt.DefinedOperation.LOCK -> {
                            result = finder?.lock()?.await()
                        }
                        Gatt.DefinedOperation.UNLOCK -> {
                            result = finder?.lock()?.await()
                        }
                        Gatt.DefinedOperation.PUBLIC_KEY -> {
                            val key = sentinelX?.getPublicKey()?.await()
                            val value = key?.value
                            if (value != null) {
                                result = XYBluetoothResult(value.toBase58String())
                            } else {
                                result = XYBluetoothResult(false)
                            }
                        }
                        else -> {
                            result = XYBluetoothResult(false)
                        }
                    }
                    return@connection XYBluetoothResult(true)
                }.await()
                return@async result
            }
        }
    }
}
