class XyoDeviceChannel: XyoBaseChannel {

override
init(registrar: FlutterPluginRegistrar, name: String) {
    bridgeManager = BridgeManager.instance
    XYBluetoothManager.setup()
    super.init(registrar: registrar, name: name)
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
        super.onMethodCall(call, result:result)
        break
    }
  }

  private func start(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    sendResult(result, true)
  }

  private func stop(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    sendResult(result, true)
  }

  private func gattSingle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    sendResult(result,GattSingleRequest.process(smartScan, call.arguments, result))
  }

  private func gattGroup(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    sendResult(result,GattGroupRequest.process(smartScan, call.arguments, result))
  }

  private func gattList(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    sendResult(result,GattGroupRequest.process(smartScan, call.arguments, result))
  }
}
