class XyoBridgeChannel: XyoNodeChannel {
    
    override
    init(registrar: FlutterPluginRegistrar, name: String) {
        super.init(registrar: registrar, name: name)
        bridgeManager = BridgeManager.instance
        XYBluetoothManager.setup()
    }

  override func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      switch (call.method) {
      case "setArchivists":
        setArchivists(call, result)
        break
      case "getBlockCount":
        getBlockCount(call, result)
        break
      case "getLastBlock":
        getLastBlock(call, result)
        break
      case "selfSign":
        selfSign(call, result)
        break
      default:
        super.handle(call, result:result)
      }
  }

  override func onStart() {
    XYBluetoothManager.start()
  }

  override func onStop() {
    XYBluetoothManager.stop()
  }

  private func setArchivists(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    notImplemented(result)
  }

  private func selfSign(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    bridgeManager.bridge.selfSignOriginChain()

    //now that we have a new last block
    getLastBlock(call, result)
  }

  private func getBlockCount(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    var hashes = bridgeManager.bridge.blockRepository.getAllOriginBlockHashes()
    if (hashes == nil) {
        result(nil)
        return
    }
    
    var models = hashesToBoundWitnesses(hashes)
    result(models.count())
  }

  private func getLastBlockData() {
    var hash = bridgeManager.bridge.originState.previousHash
    if (hash == nil) {
        result(nil)
        return
    }
    
    var structure = XyoIterableStructure(hash.bytesCopy, 0)

    var hashArray = arrayOf(structure[0])
    var hashArrayIterator = hashArray.iterator()
    var boundWitnesses = hashesToBoundWitnesses(hashArrayIterator)
    return boundWitnesses[0]
  }

  private func getLastBlock(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    var lastModel: BoundWitness.DeviceBoundWitness? = getLastBlockData()
    result(lastModel?.toByteArray())
  }

  private func hashesToBoundWitnesses(hashes: Iterator<XyoObjectStructure>) -> ArrayList<BoundWitness.DeviceBoundWitness> {
    var models = ArrayList<BoundWitness.DeviceBoundWitness>()

    hashes.forEach(hash) {
      var model = InteractionModel(bridgeManager.bridge.blockRepository, hash.bytesCopy, Date(), true)
      models.add(model.toBuffer())
    }

    return models
  }

  private func notifyNewBoundWitness() {
      var boundWitness = getLastBlockData()

      if (boundWitness != null) {
        events.send(boundWitness.toByteArray())
      }
  }

  private var onBoundWitness = XyoNodeListener() {
    override func onBoundWitnessEndSuccess(boundWitness: XyoBoundWitness) {
      notifyNewBoundWitness()
    }
  }
}
