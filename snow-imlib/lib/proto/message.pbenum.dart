///
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

// ignore_for_file: UNDEFINED_SHOWN_NAME,UNUSED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class HeartBeatType extends $pb.ProtobufEnum {
  static const HeartBeatType PING = HeartBeatType._(0, 'PING');
  static const HeartBeatType PONG = HeartBeatType._(1, 'PONG');

  static const $core.List<HeartBeatType> values = <HeartBeatType> [
    PING,
    PONG,
  ];

  static final $core.Map<$core.int, HeartBeatType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static HeartBeatType valueOf($core.int value) => _byValue[value];

  const HeartBeatType._($core.int v, $core.String n) : super(v, n);
}

class Code extends $pb.ProtobufEnum {
  static const Code SUCCESS = Code._(0, 'SUCCESS');
  static const Code CLIENT_ID_REPEAT = Code._(1, 'CLIENT_ID_REPEAT');
  static const Code CONVER_TYPE_INVALID = Code._(2, 'CONVER_TYPE_INVALID');
  static const Code KAFKA_ERROR = Code._(3, 'KAFKA_ERROR');
  static const Code CONVER_ID_INVALID = Code._(4, 'CONVER_ID_INVALID');
  static const Code NO_TARGET = Code._(5, 'NO_TARGET');
  static const Code TOKEN_INVALID = Code._(6, 'TOKEN_INVALID');
  static const Code OPERATION_TYPE_INVALID = Code._(7, 'OPERATION_TYPE_INVALID');

  static const $core.List<Code> values = <Code> [
    SUCCESS,
    CLIENT_ID_REPEAT,
    CONVER_TYPE_INVALID,
    KAFKA_ERROR,
    CONVER_ID_INVALID,
    NO_TARGET,
    TOKEN_INVALID,
    OPERATION_TYPE_INVALID,
  ];

  static final $core.Map<$core.int, Code> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Code valueOf($core.int value) => _byValue[value];

  const Code._($core.int v, $core.String n) : super(v, n);
}

class ConversationType extends $pb.ProtobufEnum {
  static const ConversationType SINGLE = ConversationType._(0, 'SINGLE');
  static const ConversationType GROUP = ConversationType._(1, 'GROUP');

  static const $core.List<ConversationType> values = <ConversationType> [
    SINGLE,
    GROUP,
  ];

  static final $core.Map<$core.int, ConversationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static ConversationType valueOf($core.int value) => _byValue[value];

  const ConversationType._($core.int v, $core.String n) : super(v, n);
}

class OperationType extends $pb.ProtobufEnum {
  static const OperationType DETAIL = OperationType._(0, 'DETAIL');
  static const OperationType ALL = OperationType._(1, 'ALL');

  static const $core.List<OperationType> values = <OperationType> [
    DETAIL,
    ALL,
  ];

  static final $core.Map<$core.int, OperationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static OperationType valueOf($core.int value) => _byValue[value];

  const OperationType._($core.int v, $core.String n) : super(v, n);
}

class NotifyType extends $pb.ProtobufEnum {
  static const NotifyType USER = NotifyType._(0, 'USER');
  static const NotifyType CONVERSATION = NotifyType._(1, 'CONVERSATION');

  static const $core.List<NotifyType> values = <NotifyType> [
    USER,
    CONVERSATION,
  ];

  static final $core.Map<$core.int, NotifyType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NotifyType valueOf($core.int value) => _byValue[value];

  const NotifyType._($core.int v, $core.String n) : super(v, n);
}

class SnowMessage_Type extends $pb.ProtobufEnum {
  static const SnowMessage_Type Login = SnowMessage_Type._(0, 'Login');
  static const SnowMessage_Type LoginAck = SnowMessage_Type._(1, 'LoginAck');
  static const SnowMessage_Type ServerInfo = SnowMessage_Type._(2, 'ServerInfo');
  static const SnowMessage_Type UpDownMessage = SnowMessage_Type._(3, 'UpDownMessage');
  static const SnowMessage_Type HeartBeat = SnowMessage_Type._(4, 'HeartBeat');
  static const SnowMessage_Type MessageAck = SnowMessage_Type._(5, 'MessageAck');
  static const SnowMessage_Type HisMessagesReq = SnowMessage_Type._(6, 'HisMessagesReq');
  static const SnowMessage_Type HisMessagesAck = SnowMessage_Type._(7, 'HisMessagesAck');
  static const SnowMessage_Type NotifyMessage = SnowMessage_Type._(8, 'NotifyMessage');
  static const SnowMessage_Type ConversationReq = SnowMessage_Type._(9, 'ConversationReq');
  static const SnowMessage_Type ConversationAck = SnowMessage_Type._(10, 'ConversationAck');

  static const $core.List<SnowMessage_Type> values = <SnowMessage_Type> [
    Login,
    LoginAck,
    ServerInfo,
    UpDownMessage,
    HeartBeat,
    MessageAck,
    HisMessagesReq,
    HisMessagesAck,
    NotifyMessage,
    ConversationReq,
    ConversationAck,
  ];

  static final $core.Map<$core.int, SnowMessage_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SnowMessage_Type valueOf($core.int value) => _byValue[value];

  const SnowMessage_Type._($core.int v, $core.String n) : super(v, n);
}

