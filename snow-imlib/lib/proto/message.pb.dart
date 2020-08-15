///
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'message.pbenum.dart';

export 'message.pbenum.dart';

enum SnowMessage_Data {
  login, 
  loginAck, 
  serverInfo, 
  upDownMessage, 
  heartBeat, 
  messageAck, 
  hisMessagesReq, 
  hisMessagesAck, 
  notifyMessage, 
  conversationReq, 
  conversationAck, 
  notSet
}

class SnowMessage extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, SnowMessage_Data> _SnowMessage_DataByTag = {
    2 : SnowMessage_Data.login,
    3 : SnowMessage_Data.loginAck,
    4 : SnowMessage_Data.serverInfo,
    5 : SnowMessage_Data.upDownMessage,
    6 : SnowMessage_Data.heartBeat,
    7 : SnowMessage_Data.messageAck,
    8 : SnowMessage_Data.hisMessagesReq,
    9 : SnowMessage_Data.hisMessagesAck,
    10 : SnowMessage_Data.notifyMessage,
    11 : SnowMessage_Data.conversationReq,
    12 : SnowMessage_Data.conversationAck,
    0 : SnowMessage_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('SnowMessage', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..oo(0, [2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12])
    ..e<SnowMessage_Type>(1, 'type', $pb.PbFieldType.OE, defaultOrMaker: SnowMessage_Type.Login, valueOf: SnowMessage_Type.valueOf, enumValues: SnowMessage_Type.values)
    ..aOM<Login>(2, 'login', subBuilder: Login.create)
    ..aOM<LoginAck>(3, 'loginAck', protoName: 'loginAck', subBuilder: LoginAck.create)
    ..aOM<ServerInfo>(4, 'serverInfo', protoName: 'serverInfo', subBuilder: ServerInfo.create)
    ..aOM<UpDownMessage>(5, 'upDownMessage', protoName: 'upDownMessage', subBuilder: UpDownMessage.create)
    ..aOM<HeartBeat>(6, 'heartBeat', protoName: 'heartBeat', subBuilder: HeartBeat.create)
    ..aOM<MessageAck>(7, 'messageAck', protoName: 'messageAck', subBuilder: MessageAck.create)
    ..aOM<HisMessagesReq>(8, 'hisMessagesReq', protoName: 'hisMessagesReq', subBuilder: HisMessagesReq.create)
    ..aOM<HisMessagesAck>(9, 'hisMessagesAck', protoName: 'hisMessagesAck', subBuilder: HisMessagesAck.create)
    ..aOM<NotifyMessage>(10, 'notifyMessage', protoName: 'notifyMessage', subBuilder: NotifyMessage.create)
    ..aOM<ConversationReq>(11, 'conversationReq', protoName: 'conversationReq', subBuilder: ConversationReq.create)
    ..aOM<ConversationAck>(12, 'conversationAck', protoName: 'conversationAck', subBuilder: ConversationAck.create)
    ..hasRequiredFields = false
  ;

  SnowMessage._() : super();
  factory SnowMessage() => create();
  factory SnowMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SnowMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  SnowMessage clone() => SnowMessage()..mergeFromMessage(this);
  SnowMessage copyWith(void Function(SnowMessage) updates) => super.copyWith((message) => updates(message as SnowMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static SnowMessage create() => SnowMessage._();
  SnowMessage createEmptyInstance() => create();
  static $pb.PbList<SnowMessage> createRepeated() => $pb.PbList<SnowMessage>();
  @$core.pragma('dart2js:noInline')
  static SnowMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SnowMessage>(create);
  static SnowMessage _defaultInstance;

  SnowMessage_Data whichData() => _SnowMessage_DataByTag[$_whichOneof(0)];
  void clearData() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  SnowMessage_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(SnowMessage_Type v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  Login get login => $_getN(1);
  @$pb.TagNumber(2)
  set login(Login v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasLogin() => $_has(1);
  @$pb.TagNumber(2)
  void clearLogin() => clearField(2);
  @$pb.TagNumber(2)
  Login ensureLogin() => $_ensure(1);

  @$pb.TagNumber(3)
  LoginAck get loginAck => $_getN(2);
  @$pb.TagNumber(3)
  set loginAck(LoginAck v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasLoginAck() => $_has(2);
  @$pb.TagNumber(3)
  void clearLoginAck() => clearField(3);
  @$pb.TagNumber(3)
  LoginAck ensureLoginAck() => $_ensure(2);

  @$pb.TagNumber(4)
  ServerInfo get serverInfo => $_getN(3);
  @$pb.TagNumber(4)
  set serverInfo(ServerInfo v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasServerInfo() => $_has(3);
  @$pb.TagNumber(4)
  void clearServerInfo() => clearField(4);
  @$pb.TagNumber(4)
  ServerInfo ensureServerInfo() => $_ensure(3);

  @$pb.TagNumber(5)
  UpDownMessage get upDownMessage => $_getN(4);
  @$pb.TagNumber(5)
  set upDownMessage(UpDownMessage v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasUpDownMessage() => $_has(4);
  @$pb.TagNumber(5)
  void clearUpDownMessage() => clearField(5);
  @$pb.TagNumber(5)
  UpDownMessage ensureUpDownMessage() => $_ensure(4);

  @$pb.TagNumber(6)
  HeartBeat get heartBeat => $_getN(5);
  @$pb.TagNumber(6)
  set heartBeat(HeartBeat v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasHeartBeat() => $_has(5);
  @$pb.TagNumber(6)
  void clearHeartBeat() => clearField(6);
  @$pb.TagNumber(6)
  HeartBeat ensureHeartBeat() => $_ensure(5);

  @$pb.TagNumber(7)
  MessageAck get messageAck => $_getN(6);
  @$pb.TagNumber(7)
  set messageAck(MessageAck v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasMessageAck() => $_has(6);
  @$pb.TagNumber(7)
  void clearMessageAck() => clearField(7);
  @$pb.TagNumber(7)
  MessageAck ensureMessageAck() => $_ensure(6);

  @$pb.TagNumber(8)
  HisMessagesReq get hisMessagesReq => $_getN(7);
  @$pb.TagNumber(8)
  set hisMessagesReq(HisMessagesReq v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasHisMessagesReq() => $_has(7);
  @$pb.TagNumber(8)
  void clearHisMessagesReq() => clearField(8);
  @$pb.TagNumber(8)
  HisMessagesReq ensureHisMessagesReq() => $_ensure(7);

  @$pb.TagNumber(9)
  HisMessagesAck get hisMessagesAck => $_getN(8);
  @$pb.TagNumber(9)
  set hisMessagesAck(HisMessagesAck v) { setField(9, v); }
  @$pb.TagNumber(9)
  $core.bool hasHisMessagesAck() => $_has(8);
  @$pb.TagNumber(9)
  void clearHisMessagesAck() => clearField(9);
  @$pb.TagNumber(9)
  HisMessagesAck ensureHisMessagesAck() => $_ensure(8);

  @$pb.TagNumber(10)
  NotifyMessage get notifyMessage => $_getN(9);
  @$pb.TagNumber(10)
  set notifyMessage(NotifyMessage v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasNotifyMessage() => $_has(9);
  @$pb.TagNumber(10)
  void clearNotifyMessage() => clearField(10);
  @$pb.TagNumber(10)
  NotifyMessage ensureNotifyMessage() => $_ensure(9);

  @$pb.TagNumber(11)
  ConversationReq get conversationReq => $_getN(10);
  @$pb.TagNumber(11)
  set conversationReq(ConversationReq v) { setField(11, v); }
  @$pb.TagNumber(11)
  $core.bool hasConversationReq() => $_has(10);
  @$pb.TagNumber(11)
  void clearConversationReq() => clearField(11);
  @$pb.TagNumber(11)
  ConversationReq ensureConversationReq() => $_ensure(10);

  @$pb.TagNumber(12)
  ConversationAck get conversationAck => $_getN(11);
  @$pb.TagNumber(12)
  set conversationAck(ConversationAck v) { setField(12, v); }
  @$pb.TagNumber(12)
  $core.bool hasConversationAck() => $_has(11);
  @$pb.TagNumber(12)
  void clearConversationAck() => clearField(12);
  @$pb.TagNumber(12)
  ConversationAck ensureConversationAck() => $_ensure(11);
}

class Login extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('Login', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, 'uid')
    ..aOS(3, 'token')
    ..hasRequiredFields = false
  ;

  Login._() : super();
  factory Login() => create();
  factory Login.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Login.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  Login clone() => Login()..mergeFromMessage(this);
  Login copyWith(void Function(Login) updates) => super.copyWith((message) => updates(message as Login));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Login create() => Login._();
  Login createEmptyInstance() => create();
  static $pb.PbList<Login> createRepeated() => $pb.PbList<Login>();
  @$core.pragma('dart2js:noInline')
  static Login getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Login>(create);
  static Login _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get uid => $_getSZ(1);
  @$pb.TagNumber(2)
  set uid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get token => $_getSZ(2);
  @$pb.TagNumber(3)
  set token($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasToken() => $_has(2);
  @$pb.TagNumber(3)
  void clearToken() => clearField(3);
}

class LoginAck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('LoginAck', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<Code>(2, 'code', $pb.PbFieldType.OE, defaultOrMaker: Code.SUCCESS, valueOf: Code.valueOf, enumValues: Code.values)
    ..aOS(3, 'msg')
    ..a<$fixnum.Int64>(4, 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  LoginAck._() : super();
  factory LoginAck() => create();
  factory LoginAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory LoginAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  LoginAck clone() => LoginAck()..mergeFromMessage(this);
  LoginAck copyWith(void Function(LoginAck) updates) => super.copyWith((message) => updates(message as LoginAck));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static LoginAck create() => LoginAck._();
  LoginAck createEmptyInstance() => create();
  static $pb.PbList<LoginAck> createRepeated() => $pb.PbList<LoginAck>();
  @$core.pragma('dart2js:noInline')
  static LoginAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<LoginAck>(create);
  static LoginAck _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  Code get code => $_getN(1);
  @$pb.TagNumber(2)
  set code(Code v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(2)
  void clearCode() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get msg => $_getSZ(2);
  @$pb.TagNumber(3)
  set msg($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasMsg() => $_has(2);
  @$pb.TagNumber(3)
  void clearMsg() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get time => $_getI64(3);
  @$pb.TagNumber(4)
  set time($fixnum.Int64 v) { $_setInt64(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(3);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);
}

class ServerInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ServerInfo', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, 'ip')
    ..a<$core.int>(3, 'port', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  ServerInfo._() : super();
  factory ServerInfo() => create();
  factory ServerInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ServerInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ServerInfo clone() => ServerInfo()..mergeFromMessage(this);
  ServerInfo copyWith(void Function(ServerInfo) updates) => super.copyWith((message) => updates(message as ServerInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ServerInfo create() => ServerInfo._();
  ServerInfo createEmptyInstance() => create();
  static $pb.PbList<ServerInfo> createRepeated() => $pb.PbList<ServerInfo>();
  @$core.pragma('dart2js:noInline')
  static ServerInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ServerInfo>(create);
  static ServerInfo _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get ip => $_getSZ(1);
  @$pb.TagNumber(2)
  set ip($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasIp() => $_has(1);
  @$pb.TagNumber(2)
  void clearIp() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get port => $_getIZ(2);
  @$pb.TagNumber(3)
  set port($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPort() => $_has(2);
  @$pb.TagNumber(3)
  void clearPort() => clearField(3);
}

class UpDownMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('UpDownMessage', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, 'cid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, 'fromUid', protoName: 'fromUid')
    ..aOS(4, 'targetUid', protoName: 'targetUid')
    ..aOS(5, 'groupId', protoName: 'groupId')
    ..aOS(6, 'conversationId', protoName: 'conversationId')
    ..e<ConversationType>(7, 'conversationType', $pb.PbFieldType.OE, protoName: 'conversationType', defaultOrMaker: ConversationType.SINGLE, valueOf: ConversationType.valueOf, enumValues: ConversationType.values)
    ..aOM<MessageContent>(8, 'content', subBuilder: MessageContent.create)
    ..hasRequiredFields = false
  ;

  UpDownMessage._() : super();
  factory UpDownMessage() => create();
  factory UpDownMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory UpDownMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  UpDownMessage clone() => UpDownMessage()..mergeFromMessage(this);
  UpDownMessage copyWith(void Function(UpDownMessage) updates) => super.copyWith((message) => updates(message as UpDownMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static UpDownMessage create() => UpDownMessage._();
  UpDownMessage createEmptyInstance() => create();
  static $pb.PbList<UpDownMessage> createRepeated() => $pb.PbList<UpDownMessage>();
  @$core.pragma('dart2js:noInline')
  static UpDownMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<UpDownMessage>(create);
  static UpDownMessage _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cid => $_getI64(1);
  @$pb.TagNumber(2)
  set cid($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCid() => $_has(1);
  @$pb.TagNumber(2)
  void clearCid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get fromUid => $_getSZ(2);
  @$pb.TagNumber(3)
  set fromUid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasFromUid() => $_has(2);
  @$pb.TagNumber(3)
  void clearFromUid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get targetUid => $_getSZ(3);
  @$pb.TagNumber(4)
  set targetUid($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTargetUid() => $_has(3);
  @$pb.TagNumber(4)
  void clearTargetUid() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get groupId => $_getSZ(4);
  @$pb.TagNumber(5)
  set groupId($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasGroupId() => $_has(4);
  @$pb.TagNumber(5)
  void clearGroupId() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get conversationId => $_getSZ(5);
  @$pb.TagNumber(6)
  set conversationId($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasConversationId() => $_has(5);
  @$pb.TagNumber(6)
  void clearConversationId() => clearField(6);

  @$pb.TagNumber(7)
  ConversationType get conversationType => $_getN(6);
  @$pb.TagNumber(7)
  set conversationType(ConversationType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasConversationType() => $_has(6);
  @$pb.TagNumber(7)
  void clearConversationType() => clearField(7);

  @$pb.TagNumber(8)
  MessageContent get content => $_getN(7);
  @$pb.TagNumber(8)
  set content(MessageContent v) { setField(8, v); }
  @$pb.TagNumber(8)
  $core.bool hasContent() => $_has(7);
  @$pb.TagNumber(8)
  void clearContent() => clearField(8);
  @$pb.TagNumber(8)
  MessageContent ensureContent() => $_ensure(7);
}

class HeartBeat extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HeartBeat', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<HeartBeatType>(2, 'heartBeatType', $pb.PbFieldType.OE, protoName: 'heartBeatType', defaultOrMaker: HeartBeatType.PING, valueOf: HeartBeatType.valueOf, enumValues: HeartBeatType.values)
    ..hasRequiredFields = false
  ;

  HeartBeat._() : super();
  factory HeartBeat() => create();
  factory HeartBeat.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HeartBeat.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HeartBeat clone() => HeartBeat()..mergeFromMessage(this);
  HeartBeat copyWith(void Function(HeartBeat) updates) => super.copyWith((message) => updates(message as HeartBeat));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HeartBeat create() => HeartBeat._();
  HeartBeat createEmptyInstance() => create();
  static $pb.PbList<HeartBeat> createRepeated() => $pb.PbList<HeartBeat>();
  @$core.pragma('dart2js:noInline')
  static HeartBeat getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HeartBeat>(create);
  static HeartBeat _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  HeartBeatType get heartBeatType => $_getN(1);
  @$pb.TagNumber(2)
  set heartBeatType(HeartBeatType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasHeartBeatType() => $_has(1);
  @$pb.TagNumber(2)
  void clearHeartBeatType() => clearField(2);
}

class MessageAck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MessageAck', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..a<$fixnum.Int64>(2, 'cid', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(3, 'targetUid', protoName: 'targetUid')
    ..aOS(4, 'conversationId', protoName: 'conversationId')
    ..a<$fixnum.Int64>(5, 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<Code>(6, 'code', $pb.PbFieldType.OE, defaultOrMaker: Code.SUCCESS, valueOf: Code.valueOf, enumValues: Code.values)
    ..hasRequiredFields = false
  ;

  MessageAck._() : super();
  factory MessageAck() => create();
  factory MessageAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MessageAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MessageAck clone() => MessageAck()..mergeFromMessage(this);
  MessageAck copyWith(void Function(MessageAck) updates) => super.copyWith((message) => updates(message as MessageAck));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MessageAck create() => MessageAck._();
  MessageAck createEmptyInstance() => create();
  static $pb.PbList<MessageAck> createRepeated() => $pb.PbList<MessageAck>();
  @$core.pragma('dart2js:noInline')
  static MessageAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageAck>(create);
  static MessageAck _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $fixnum.Int64 get cid => $_getI64(1);
  @$pb.TagNumber(2)
  set cid($fixnum.Int64 v) { $_setInt64(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasCid() => $_has(1);
  @$pb.TagNumber(2)
  void clearCid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get targetUid => $_getSZ(2);
  @$pb.TagNumber(3)
  set targetUid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetUid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetUid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get conversationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set conversationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConversationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearConversationId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get time => $_getI64(4);
  @$pb.TagNumber(5)
  set time($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearTime() => clearField(5);

  @$pb.TagNumber(6)
  Code get code => $_getN(5);
  @$pb.TagNumber(6)
  set code(Code v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasCode() => $_has(5);
  @$pb.TagNumber(6)
  void clearCode() => clearField(6);
}

class MessageContent extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('MessageContent', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, 'uid')
    ..aOS(3, 'type')
    ..aOS(4, 'content')
    ..a<$fixnum.Int64>(5, 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  MessageContent._() : super();
  factory MessageContent() => create();
  factory MessageContent.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MessageContent.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  MessageContent clone() => MessageContent()..mergeFromMessage(this);
  MessageContent copyWith(void Function(MessageContent) updates) => super.copyWith((message) => updates(message as MessageContent));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MessageContent create() => MessageContent._();
  MessageContent createEmptyInstance() => create();
  static $pb.PbList<MessageContent> createRepeated() => $pb.PbList<MessageContent>();
  @$core.pragma('dart2js:noInline')
  static MessageContent getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MessageContent>(create);
  static MessageContent _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get uid => $_getSZ(1);
  @$pb.TagNumber(2)
  set uid($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUid() => $_has(1);
  @$pb.TagNumber(2)
  void clearUid() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get type => $_getSZ(2);
  @$pb.TagNumber(3)
  set type($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasType() => $_has(2);
  @$pb.TagNumber(3)
  void clearType() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get content => $_getSZ(3);
  @$pb.TagNumber(4)
  set content($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasContent() => $_has(3);
  @$pb.TagNumber(4)
  void clearContent() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get time => $_getI64(4);
  @$pb.TagNumber(5)
  set time($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasTime() => $_has(4);
  @$pb.TagNumber(5)
  void clearTime() => clearField(5);
}

class HisMessagesReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HisMessagesReq', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, 'conversationId', protoName: 'conversationId')
    ..a<$fixnum.Int64>(3, 'beginId', $pb.PbFieldType.OU6, protoName: 'beginId', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  HisMessagesReq._() : super();
  factory HisMessagesReq() => create();
  factory HisMessagesReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HisMessagesReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HisMessagesReq clone() => HisMessagesReq()..mergeFromMessage(this);
  HisMessagesReq copyWith(void Function(HisMessagesReq) updates) => super.copyWith((message) => updates(message as HisMessagesReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HisMessagesReq create() => HisMessagesReq._();
  HisMessagesReq createEmptyInstance() => create();
  static $pb.PbList<HisMessagesReq> createRepeated() => $pb.PbList<HisMessagesReq>();
  @$core.pragma('dart2js:noInline')
  static HisMessagesReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HisMessagesReq>(create);
  static HisMessagesReq _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConversationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationId() => clearField(2);

  @$pb.TagNumber(3)
  $fixnum.Int64 get beginId => $_getI64(2);
  @$pb.TagNumber(3)
  set beginId($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasBeginId() => $_has(2);
  @$pb.TagNumber(3)
  void clearBeginId() => clearField(3);
}

class HisMessagesAck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('HisMessagesAck', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(2, 'conversationId', protoName: 'conversationId')
    ..e<ConversationType>(3, 'convType', $pb.PbFieldType.OE, protoName: 'convType', defaultOrMaker: ConversationType.SINGLE, valueOf: ConversationType.valueOf, enumValues: ConversationType.values)
    ..pc<MessageContent>(4, 'messageList', $pb.PbFieldType.PM, protoName: 'messageList', subBuilder: MessageContent.create)
    ..a<$fixnum.Int64>(5, 'unReadCount', $pb.PbFieldType.OU6, protoName: 'unReadCount', defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  HisMessagesAck._() : super();
  factory HisMessagesAck() => create();
  factory HisMessagesAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory HisMessagesAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  HisMessagesAck clone() => HisMessagesAck()..mergeFromMessage(this);
  HisMessagesAck copyWith(void Function(HisMessagesAck) updates) => super.copyWith((message) => updates(message as HisMessagesAck));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static HisMessagesAck create() => HisMessagesAck._();
  HisMessagesAck createEmptyInstance() => create();
  static $pb.PbList<HisMessagesAck> createRepeated() => $pb.PbList<HisMessagesAck>();
  @$core.pragma('dart2js:noInline')
  static HisMessagesAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<HisMessagesAck>(create);
  static HisMessagesAck _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get conversationId => $_getSZ(1);
  @$pb.TagNumber(2)
  set conversationId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasConversationId() => $_has(1);
  @$pb.TagNumber(2)
  void clearConversationId() => clearField(2);

  @$pb.TagNumber(3)
  ConversationType get convType => $_getN(2);
  @$pb.TagNumber(3)
  set convType(ConversationType v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasConvType() => $_has(2);
  @$pb.TagNumber(3)
  void clearConvType() => clearField(3);

  @$pb.TagNumber(4)
  $core.List<MessageContent> get messageList => $_getList(3);

  @$pb.TagNumber(5)
  $fixnum.Int64 get unReadCount => $_getI64(4);
  @$pb.TagNumber(5)
  set unReadCount($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasUnReadCount() => $_has(4);
  @$pb.TagNumber(5)
  void clearUnReadCount() => clearField(5);
}

class ConversationReq extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ConversationReq', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<OperationType>(2, 'type', $pb.PbFieldType.OE, defaultOrMaker: OperationType.DETAIL, valueOf: OperationType.valueOf, enumValues: OperationType.values)
    ..aOS(3, 'conversationId', protoName: 'conversationId')
    ..hasRequiredFields = false
  ;

  ConversationReq._() : super();
  factory ConversationReq() => create();
  factory ConversationReq.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConversationReq.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ConversationReq clone() => ConversationReq()..mergeFromMessage(this);
  ConversationReq copyWith(void Function(ConversationReq) updates) => super.copyWith((message) => updates(message as ConversationReq));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConversationReq create() => ConversationReq._();
  ConversationReq createEmptyInstance() => create();
  static $pb.PbList<ConversationReq> createRepeated() => $pb.PbList<ConversationReq>();
  @$core.pragma('dart2js:noInline')
  static ConversationReq getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConversationReq>(create);
  static ConversationReq _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  OperationType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(OperationType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get conversationId => $_getSZ(2);
  @$pb.TagNumber(3)
  set conversationId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasConversationId() => $_has(2);
  @$pb.TagNumber(3)
  void clearConversationId() => clearField(3);
}

class ConversationAck extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ConversationAck', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<Code>(3, 'code', $pb.PbFieldType.OE, defaultOrMaker: Code.SUCCESS, valueOf: Code.valueOf, enumValues: Code.values)
    ..a<$fixnum.Int64>(4, 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<ConversationInfo>(5, 'conversationInfo', protoName: 'conversationInfo', subBuilder: ConversationInfo.create)
    ..pc<ConversationInfo>(6, 'conversationList', $pb.PbFieldType.PM, protoName: 'conversationList', subBuilder: ConversationInfo.create)
    ..hasRequiredFields = false
  ;

  ConversationAck._() : super();
  factory ConversationAck() => create();
  factory ConversationAck.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConversationAck.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ConversationAck clone() => ConversationAck()..mergeFromMessage(this);
  ConversationAck copyWith(void Function(ConversationAck) updates) => super.copyWith((message) => updates(message as ConversationAck));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConversationAck create() => ConversationAck._();
  ConversationAck createEmptyInstance() => create();
  static $pb.PbList<ConversationAck> createRepeated() => $pb.PbList<ConversationAck>();
  @$core.pragma('dart2js:noInline')
  static ConversationAck getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConversationAck>(create);
  static ConversationAck _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(3)
  Code get code => $_getN(1);
  @$pb.TagNumber(3)
  set code(Code v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCode() => $_has(1);
  @$pb.TagNumber(3)
  void clearCode() => clearField(3);

  @$pb.TagNumber(4)
  $fixnum.Int64 get time => $_getI64(2);
  @$pb.TagNumber(4)
  set time($fixnum.Int64 v) { $_setInt64(2, v); }
  @$pb.TagNumber(4)
  $core.bool hasTime() => $_has(2);
  @$pb.TagNumber(4)
  void clearTime() => clearField(4);

  @$pb.TagNumber(5)
  ConversationInfo get conversationInfo => $_getN(3);
  @$pb.TagNumber(5)
  set conversationInfo(ConversationInfo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasConversationInfo() => $_has(3);
  @$pb.TagNumber(5)
  void clearConversationInfo() => clearField(5);
  @$pb.TagNumber(5)
  ConversationInfo ensureConversationInfo() => $_ensure(3);

  @$pb.TagNumber(6)
  $core.List<ConversationInfo> get conversationList => $_getList(4);
}

class ConversationInfo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('ConversationInfo', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..aOS(1, 'conversationId', protoName: 'conversationId')
    ..e<ConversationType>(2, 'type', $pb.PbFieldType.OE, defaultOrMaker: ConversationType.SINGLE, valueOf: ConversationType.valueOf, enumValues: ConversationType.values)
    ..pPS(3, 'uidList', protoName: 'uidList')
    ..aOS(4, 'groupId', protoName: 'groupId')
    ..a<$fixnum.Int64>(5, 'readMsgId', $pb.PbFieldType.OU6, protoName: 'readMsgId', defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOM<MessageContent>(6, 'lastContent', protoName: 'lastContent', subBuilder: MessageContent.create)
    ..a<$fixnum.Int64>(7, 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..hasRequiredFields = false
  ;

  ConversationInfo._() : super();
  factory ConversationInfo() => create();
  factory ConversationInfo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ConversationInfo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  ConversationInfo clone() => ConversationInfo()..mergeFromMessage(this);
  ConversationInfo copyWith(void Function(ConversationInfo) updates) => super.copyWith((message) => updates(message as ConversationInfo));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static ConversationInfo create() => ConversationInfo._();
  ConversationInfo createEmptyInstance() => create();
  static $pb.PbList<ConversationInfo> createRepeated() => $pb.PbList<ConversationInfo>();
  @$core.pragma('dart2js:noInline')
  static ConversationInfo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ConversationInfo>(create);
  static ConversationInfo _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get conversationId => $_getSZ(0);
  @$pb.TagNumber(1)
  set conversationId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasConversationId() => $_has(0);
  @$pb.TagNumber(1)
  void clearConversationId() => clearField(1);

  @$pb.TagNumber(2)
  ConversationType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(ConversationType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.String> get uidList => $_getList(2);

  @$pb.TagNumber(4)
  $core.String get groupId => $_getSZ(3);
  @$pb.TagNumber(4)
  set groupId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasGroupId() => $_has(3);
  @$pb.TagNumber(4)
  void clearGroupId() => clearField(4);

  @$pb.TagNumber(5)
  $fixnum.Int64 get readMsgId => $_getI64(4);
  @$pb.TagNumber(5)
  set readMsgId($fixnum.Int64 v) { $_setInt64(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasReadMsgId() => $_has(4);
  @$pb.TagNumber(5)
  void clearReadMsgId() => clearField(5);

  @$pb.TagNumber(6)
  MessageContent get lastContent => $_getN(5);
  @$pb.TagNumber(6)
  set lastContent(MessageContent v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasLastContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearLastContent() => clearField(6);
  @$pb.TagNumber(6)
  MessageContent ensureLastContent() => $_ensure(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get time => $_getI64(6);
  @$pb.TagNumber(7)
  set time($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearTime() => clearField(7);
}

class NotifyMessage extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo('NotifyMessage', package: const $pb.PackageName('com.snow.proto.message'), createEmptyInstance: create)
    ..a<$fixnum.Int64>(1, 'id', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..e<NotifyType>(2, 'type', $pb.PbFieldType.OE, defaultOrMaker: NotifyType.USER, valueOf: NotifyType.valueOf, enumValues: NotifyType.values)
    ..aOS(3, 'targetUid', protoName: 'targetUid')
    ..aOS(4, 'conversationId', protoName: 'conversationId')
    ..e<ConversationType>(5, 'convType', $pb.PbFieldType.OE, protoName: 'convType', defaultOrMaker: ConversationType.SINGLE, valueOf: ConversationType.valueOf, enumValues: ConversationType.values)
    ..aOS(6, 'content')
    ..a<$fixnum.Int64>(7, 'time', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, 'fromUid', protoName: 'fromUid')
    ..hasRequiredFields = false
  ;

  NotifyMessage._() : super();
  factory NotifyMessage() => create();
  factory NotifyMessage.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NotifyMessage.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  NotifyMessage clone() => NotifyMessage()..mergeFromMessage(this);
  NotifyMessage copyWith(void Function(NotifyMessage) updates) => super.copyWith((message) => updates(message as NotifyMessage));
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NotifyMessage create() => NotifyMessage._();
  NotifyMessage createEmptyInstance() => create();
  static $pb.PbList<NotifyMessage> createRepeated() => $pb.PbList<NotifyMessage>();
  @$core.pragma('dart2js:noInline')
  static NotifyMessage getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NotifyMessage>(create);
  static NotifyMessage _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get id => $_getI64(0);
  @$pb.TagNumber(1)
  set id($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  NotifyType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(NotifyType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get targetUid => $_getSZ(2);
  @$pb.TagNumber(3)
  set targetUid($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTargetUid() => $_has(2);
  @$pb.TagNumber(3)
  void clearTargetUid() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get conversationId => $_getSZ(3);
  @$pb.TagNumber(4)
  set conversationId($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasConversationId() => $_has(3);
  @$pb.TagNumber(4)
  void clearConversationId() => clearField(4);

  @$pb.TagNumber(5)
  ConversationType get convType => $_getN(4);
  @$pb.TagNumber(5)
  set convType(ConversationType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasConvType() => $_has(4);
  @$pb.TagNumber(5)
  void clearConvType() => clearField(5);

  @$pb.TagNumber(6)
  $core.String get content => $_getSZ(5);
  @$pb.TagNumber(6)
  set content($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasContent() => $_has(5);
  @$pb.TagNumber(6)
  void clearContent() => clearField(6);

  @$pb.TagNumber(7)
  $fixnum.Int64 get time => $_getI64(6);
  @$pb.TagNumber(7)
  set time($fixnum.Int64 v) { $_setInt64(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasTime() => $_has(6);
  @$pb.TagNumber(7)
  void clearTime() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get fromUid => $_getSZ(7);
  @$pb.TagNumber(8)
  set fromUid($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasFromUid() => $_has(7);
  @$pb.TagNumber(8)
  void clearFromUid() => clearField(8);
}

