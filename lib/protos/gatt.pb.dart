///
//  Generated code. Do not modify.
//  source: protos/gatt.proto
///
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name

import 'dart:core' as $core show bool, Deprecated, double, int, List, Map, override, String;

import 'package:protobuf/protobuf.dart' as $pb;

import 'gatt.pbenum.dart';

export 'gatt.pbenum.dart';

class GattOperationList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GattOperationList')
    ..aOS(1, 'deviceId')
    ..pc<GattOperation>(2, 'operations', $pb.PbFieldType.PM,GattOperation.create)
    ..aOB(3, 'disconnectOnCompletion')
    ..hasRequiredFields = false
  ;

  GattOperationList() : super();
  GattOperationList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GattOperationList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GattOperationList clone() => GattOperationList()..mergeFromMessage(this);
  GattOperationList copyWith(void Function(GattOperationList) updates) => super.copyWith((message) => updates(message as GattOperationList));
  $pb.BuilderInfo get info_ => _i;
  static GattOperationList create() => GattOperationList();
  GattOperationList createEmptyInstance() => create();
  static $pb.PbList<GattOperationList> createRepeated() => $pb.PbList<GattOperationList>();
  static GattOperationList getDefault() => _defaultInstance ??= create()..freeze();
  static GattOperationList _defaultInstance;

  $core.String get deviceId => $_getS(0, '');
  set deviceId($core.String v) { $_setString(0, v); }
  $core.bool hasDeviceId() => $_has(0);
  void clearDeviceId() => clearField(1);

  $core.List<GattOperation> get operations => $_getList(1);

  $core.bool get disconnectOnCompletion => $_get(2, false);
  set disconnectOnCompletion($core.bool v) { $_setBool(2, v); }
  $core.bool hasDisconnectOnCompletion() => $_has(2);
  void clearDisconnectOnCompletion() => clearField(3);
}

class GattCall extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GattCall')
    ..aOS(1, 'serviceUuid')
    ..aOS(2, 'characteristicUuid')
    ..hasRequiredFields = false
  ;

  GattCall() : super();
  GattCall.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GattCall.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GattCall clone() => GattCall()..mergeFromMessage(this);
  GattCall copyWith(void Function(GattCall) updates) => super.copyWith((message) => updates(message as GattCall));
  $pb.BuilderInfo get info_ => _i;
  static GattCall create() => GattCall();
  GattCall createEmptyInstance() => create();
  static $pb.PbList<GattCall> createRepeated() => $pb.PbList<GattCall>();
  static GattCall getDefault() => _defaultInstance ??= create()..freeze();
  static GattCall _defaultInstance;

  $core.String get serviceUuid => $_getS(0, '');
  set serviceUuid($core.String v) { $_setString(0, v); }
  $core.bool hasServiceUuid() => $_has(0);
  void clearServiceUuid() => clearField(1);

  $core.String get characteristicUuid => $_getS(1, '');
  set characteristicUuid($core.String v) { $_setString(1, v); }
  $core.bool hasCharacteristicUuid() => $_has(1);
  void clearCharacteristicUuid() => clearField(2);
}

class GattOperation_Write extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GattOperation.Write')
    ..a<$core.List<$core.int>>(1, 'request', $pb.PbFieldType.OY)
    ..aOB(2, 'requiresResponse')
    ..hasRequiredFields = false
  ;

  GattOperation_Write() : super();
  GattOperation_Write.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GattOperation_Write.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GattOperation_Write clone() => GattOperation_Write()..mergeFromMessage(this);
  GattOperation_Write copyWith(void Function(GattOperation_Write) updates) => super.copyWith((message) => updates(message as GattOperation_Write));
  $pb.BuilderInfo get info_ => _i;
  static GattOperation_Write create() => GattOperation_Write();
  GattOperation_Write createEmptyInstance() => create();
  static $pb.PbList<GattOperation_Write> createRepeated() => $pb.PbList<GattOperation_Write>();
  static GattOperation_Write getDefault() => _defaultInstance ??= create()..freeze();
  static GattOperation_Write _defaultInstance;

  $core.List<$core.int> get request => $_getN(0);
  set request($core.List<$core.int> v) { $_setBytes(0, v); }
  $core.bool hasRequest() => $_has(0);
  void clearRequest() => clearField(1);

  $core.bool get requiresResponse => $_get(1, false);
  set requiresResponse($core.bool v) { $_setBool(1, v); }
  $core.bool hasRequiresResponse() => $_has(1);
  void clearRequiresResponse() => clearField(2);
}

enum GattOperation_Operation {
  definedOperation, 
  gattCall, 
  notSet
}

class GattOperation extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, GattOperation_Operation> _GattOperation_OperationByTag = {
    2 : GattOperation_Operation.definedOperation,
    3 : GattOperation_Operation.gattCall,
    0 : GattOperation_Operation.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GattOperation')
    ..aOS(1, 'deviceId')
    ..e<DefinedOperation>(2, 'definedOperation', $pb.PbFieldType.OE, DefinedOperation.STAY_AWAKE, DefinedOperation.valueOf, DefinedOperation.values)
    ..a<GattCall>(3, 'gattCall', $pb.PbFieldType.OM, GattCall.getDefault, GattCall.create)
    ..a<GattOperation_Write>(4, 'writeRequest', $pb.PbFieldType.OM, GattOperation_Write.getDefault, GattOperation_Write.create)
    ..aOB(5, 'disconnectOnCompletion')
    ..oo(0, [2, 3])
    ..hasRequiredFields = false
  ;

  GattOperation() : super();
  GattOperation.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GattOperation.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GattOperation clone() => GattOperation()..mergeFromMessage(this);
  GattOperation copyWith(void Function(GattOperation) updates) => super.copyWith((message) => updates(message as GattOperation));
  $pb.BuilderInfo get info_ => _i;
  static GattOperation create() => GattOperation();
  GattOperation createEmptyInstance() => create();
  static $pb.PbList<GattOperation> createRepeated() => $pb.PbList<GattOperation>();
  static GattOperation getDefault() => _defaultInstance ??= create()..freeze();
  static GattOperation _defaultInstance;

  GattOperation_Operation whichOperation() => _GattOperation_OperationByTag[$_whichOneof(0)];
  void clearOperation() => clearField($_whichOneof(0));

  $core.String get deviceId => $_getS(0, '');
  set deviceId($core.String v) { $_setString(0, v); }
  $core.bool hasDeviceId() => $_has(0);
  void clearDeviceId() => clearField(1);

  DefinedOperation get definedOperation => $_getN(1);
  set definedOperation(DefinedOperation v) { setField(2, v); }
  $core.bool hasDefinedOperation() => $_has(1);
  void clearDefinedOperation() => clearField(2);

  GattCall get gattCall => $_getN(2);
  set gattCall(GattCall v) { setField(3, v); }
  $core.bool hasGattCall() => $_has(2);
  void clearGattCall() => clearField(3);

  GattOperation_Write get writeRequest => $_getN(3);
  set writeRequest(GattOperation_Write v) { setField(4, v); }
  $core.bool hasWriteRequest() => $_has(3);
  void clearWriteRequest() => clearField(4);

  $core.bool get disconnectOnCompletion => $_get(4, false);
  set disconnectOnCompletion($core.bool v) { $_setBool(4, v); }
  $core.bool hasDisconnectOnCompletion() => $_has(4);
  void clearDisconnectOnCompletion() => clearField(5);
}

class GattResponseList extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GattResponseList')
    ..pc<GattResponse>(1, 'responses', $pb.PbFieldType.PM,GattResponse.create)
    ..hasRequiredFields = false
  ;

  GattResponseList() : super();
  GattResponseList.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GattResponseList.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GattResponseList clone() => GattResponseList()..mergeFromMessage(this);
  GattResponseList copyWith(void Function(GattResponseList) updates) => super.copyWith((message) => updates(message as GattResponseList));
  $pb.BuilderInfo get info_ => _i;
  static GattResponseList create() => GattResponseList();
  GattResponseList createEmptyInstance() => create();
  static $pb.PbList<GattResponseList> createRepeated() => $pb.PbList<GattResponseList>();
  static GattResponseList getDefault() => _defaultInstance ??= create()..freeze();
  static GattResponseList _defaultInstance;

  $core.List<GattResponse> get responses => $_getList(0);
}

enum GattResponse_Operation {
  definedOperation, 
  gattCall, 
  notSet
}

class GattResponse extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, GattResponse_Operation> _GattResponse_OperationByTag = {
    2 : GattResponse_Operation.definedOperation,
    3 : GattResponse_Operation.gattCall,
    0 : GattResponse_Operation.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('GattResponse')
    ..aOS(1, 'deviceId')
    ..e<DefinedOperation>(2, 'definedOperation', $pb.PbFieldType.OE, DefinedOperation.STAY_AWAKE, DefinedOperation.valueOf, DefinedOperation.values)
    ..a<GattCall>(3, 'gattCall', $pb.PbFieldType.OM, GattCall.getDefault, GattCall.create)
    ..a<$core.List<$core.int>>(4, 'response', $pb.PbFieldType.OY)
    ..aOS(5, 'error')
    ..oo(0, [2, 3])
    ..hasRequiredFields = false
  ;

  GattResponse() : super();
  GattResponse.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromBuffer(i, r);
  GattResponse.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) : super.fromJson(i, r);
  GattResponse clone() => GattResponse()..mergeFromMessage(this);
  GattResponse copyWith(void Function(GattResponse) updates) => super.copyWith((message) => updates(message as GattResponse));
  $pb.BuilderInfo get info_ => _i;
  static GattResponse create() => GattResponse();
  GattResponse createEmptyInstance() => create();
  static $pb.PbList<GattResponse> createRepeated() => $pb.PbList<GattResponse>();
  static GattResponse getDefault() => _defaultInstance ??= create()..freeze();
  static GattResponse _defaultInstance;

  GattResponse_Operation whichOperation() => _GattResponse_OperationByTag[$_whichOneof(0)];
  void clearOperation() => clearField($_whichOneof(0));

  $core.String get deviceId => $_getS(0, '');
  set deviceId($core.String v) { $_setString(0, v); }
  $core.bool hasDeviceId() => $_has(0);
  void clearDeviceId() => clearField(1);

  DefinedOperation get definedOperation => $_getN(1);
  set definedOperation(DefinedOperation v) { setField(2, v); }
  $core.bool hasDefinedOperation() => $_has(1);
  void clearDefinedOperation() => clearField(2);

  GattCall get gattCall => $_getN(2);
  set gattCall(GattCall v) { setField(3, v); }
  $core.bool hasGattCall() => $_has(2);
  void clearGattCall() => clearField(3);

  $core.List<$core.int> get response => $_getN(3);
  set response($core.List<$core.int> v) { $_setBytes(3, v); }
  $core.bool hasResponse() => $_has(3);
  void clearResponse() => clearField(4);

  $core.String get error => $_getS(4, '');
  set error($core.String v) { $_setString(4, v); }
  $core.bool hasError() => $_has(4);
  void clearError() => clearField(5);
}

