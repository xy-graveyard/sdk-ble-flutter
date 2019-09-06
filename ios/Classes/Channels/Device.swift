import XyBleSdk

class XyoDeviceChannel: XyoBaseChannel {
  
  let bridgeManager: BridgeManager;
  
  private let onEnterChannel: FlutterEventChannel
  private let onExitChannel: FlutterEventChannel
  private let onDetectChannel: FlutterEventChannel
  
  private let onEnter = EventStreamHandler()
  private let onExit = EventStreamHandler()
  private let onDetect = EventStreamHandler()
  
  override
  init(registrar: FlutterPluginRegistrar, name: String) {
    bridgeManager = BridgeManager.instance
    XYBluetoothManager.setup()
    
    onEnterChannel = FlutterEventChannel(name:"\(name)OnEnter", binaryMessenger: registrar.messenger())
    onEnterChannel.setStreamHandler(onEnter)
    
    onExitChannel = FlutterEventChannel(name:"\(name)OnExit", binaryMessenger: registrar.messenger())
    onExitChannel.setStreamHandler(onExit)
    
    onDetectChannel = FlutterEventChannel(name:"\(name)OnDetect", binaryMessenger: registrar.messenger())
    onDetectChannel.setStreamHandler(onDetect)
    
    super.init(registrar: registrar, name: name)
    
    XYBluetoothManager.scanner.setDelegate(self, key: "DeviceChannel")
  }
  
  override func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch (call.method) {
    case "start":
      start(call, result:result)
      break
    case "stop":
      stop(call, result:result)
      break
    case "gattSingle":
      gattSingle(call, result:result)
      break
    case "gattGroup":
      gattGroup(call, result:result)
      break
    case "gattList":
      gattList(call, result:result)
      break
    default:
      super.handle(call, result:result)
      break
    }
  }
  
  private func start(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(true)
  }
  
  private func stop(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result(true)
  }
  
  private func gattSingle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    GattSingleRequest.process(arguments: call.arguments, result: result)
  }
  
  private func gattGroup(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    GattGroupRequest.process(arguments: call.arguments, result: result)
  }
  
  private func gattList(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    GattGroupRequest.process(arguments: call.arguments, result: result)
  }
}

extension XyoDeviceChannel : XYSmartScanDelegate {
  
  func smartScan(status: XYSmartScanStatus) {}
  func smartScan(location: XYLocationCoordinate2D) {}
  func smartScan(detected device: XYBluetoothDevice, signalStrength: Int, family: XYDeviceFamily) {
    onDetect.send(event: try! device.toBuffer.serializedData())
  }
  func smartScan(detected devices: [XYBluetoothDevice], family: XYDeviceFamily) {}
  func smartScan(entered device: XYBluetoothDevice) {
    onEnter.send(event: try! device.toBuffer.serializedData())
  }
  func smartScan(exiting device:XYBluetoothDevice) {}
  func smartScan(exited device: XYBluetoothDevice) {
    onExit.send(event: try! device.toBuffer.serializedData())
  }
}
