///
//  Generated code. Do not modify.
//  source: message.proto
//
// @dart = 2.3
// ignore_for_file: camel_case_types,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type

const HeartBeatType$json = const {
  '1': 'HeartBeatType',
  '2': const [
    const {'1': 'PING', '2': 0},
    const {'1': 'PONG', '2': 1},
  ],
};

const Code$json = const {
  '1': 'Code',
  '2': const [
    const {'1': 'SUCCESS', '2': 0},
    const {'1': 'CLIENT_ID_REPEAT', '2': 1},
    const {'1': 'CONVER_TYPE_INVALID', '2': 2},
    const {'1': 'KAFKA_ERROR', '2': 3},
    const {'1': 'CONVER_ID_INVALID', '2': 4},
    const {'1': 'NO_TARGET', '2': 5},
    const {'1': 'TOKEN_INVALID', '2': 6},
    const {'1': 'OPERATION_TYPE_INVALID', '2': 7},
  ],
};

const ConversationType$json = const {
  '1': 'ConversationType',
  '2': const [
    const {'1': 'SINGLE', '2': 0},
    const {'1': 'GROUP', '2': 1},
  ],
};

const OperationType$json = const {
  '1': 'OperationType',
  '2': const [
    const {'1': 'DETAIL', '2': 0},
    const {'1': 'ALL', '2': 1},
  ],
};

const NotifyType$json = const {
  '1': 'NotifyType',
  '2': const [
    const {'1': 'USER', '2': 0},
    const {'1': 'CONVERSATION', '2': 1},
  ],
};

const SnowMessage$json = const {
  '1': 'SnowMessage',
  '2': const [
    const {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.com.snow.proto.message.SnowMessage.Type', '10': 'type'},
    const {'1': 'login', '3': 2, '4': 1, '5': 11, '6': '.com.snow.proto.message.Login', '9': 0, '10': 'login'},
    const {'1': 'loginAck', '3': 3, '4': 1, '5': 11, '6': '.com.snow.proto.message.LoginAck', '9': 0, '10': 'loginAck'},
    const {'1': 'serverInfo', '3': 4, '4': 1, '5': 11, '6': '.com.snow.proto.message.ServerInfo', '9': 0, '10': 'serverInfo'},
    const {'1': 'upDownMessage', '3': 5, '4': 1, '5': 11, '6': '.com.snow.proto.message.UpDownMessage', '9': 0, '10': 'upDownMessage'},
    const {'1': 'heartBeat', '3': 6, '4': 1, '5': 11, '6': '.com.snow.proto.message.HeartBeat', '9': 0, '10': 'heartBeat'},
    const {'1': 'messageAck', '3': 7, '4': 1, '5': 11, '6': '.com.snow.proto.message.MessageAck', '9': 0, '10': 'messageAck'},
    const {'1': 'hisMessagesReq', '3': 8, '4': 1, '5': 11, '6': '.com.snow.proto.message.HisMessagesReq', '9': 0, '10': 'hisMessagesReq'},
    const {'1': 'hisMessagesAck', '3': 9, '4': 1, '5': 11, '6': '.com.snow.proto.message.HisMessagesAck', '9': 0, '10': 'hisMessagesAck'},
    const {'1': 'notifyMessage', '3': 10, '4': 1, '5': 11, '6': '.com.snow.proto.message.NotifyMessage', '9': 0, '10': 'notifyMessage'},
    const {'1': 'conversationReq', '3': 11, '4': 1, '5': 11, '6': '.com.snow.proto.message.ConversationReq', '9': 0, '10': 'conversationReq'},
    const {'1': 'conversationAck', '3': 12, '4': 1, '5': 11, '6': '.com.snow.proto.message.ConversationAck', '9': 0, '10': 'conversationAck'},
  ],
  '4': const [SnowMessage_Type$json],
  '8': const [
    const {'1': 'data'},
  ],
};

const SnowMessage_Type$json = const {
  '1': 'Type',
  '2': const [
    const {'1': 'Login', '2': 0},
    const {'1': 'LoginAck', '2': 1},
    const {'1': 'ServerInfo', '2': 2},
    const {'1': 'UpDownMessage', '2': 3},
    const {'1': 'HeartBeat', '2': 4},
    const {'1': 'MessageAck', '2': 5},
    const {'1': 'HisMessagesReq', '2': 6},
    const {'1': 'HisMessagesAck', '2': 7},
    const {'1': 'NotifyMessage', '2': 8},
    const {'1': 'ConversationReq', '2': 9},
    const {'1': 'ConversationAck', '2': 10},
  ],
};

const Login$json = const {
  '1': 'Login',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'uid', '3': 2, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'token', '3': 3, '4': 1, '5': 9, '10': 'token'},
  ],
};

const LoginAck$json = const {
  '1': 'LoginAck',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'code', '3': 2, '4': 1, '5': 14, '6': '.com.snow.proto.message.Code', '10': 'code'},
    const {'1': 'msg', '3': 3, '4': 1, '5': 9, '10': 'msg'},
    const {'1': 'time', '3': 4, '4': 1, '5': 4, '10': 'time'},
  ],
};

const ServerInfo$json = const {
  '1': 'ServerInfo',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'ip', '3': 2, '4': 1, '5': 9, '10': 'ip'},
    const {'1': 'port', '3': 3, '4': 1, '5': 13, '10': 'port'},
  ],
};

const UpDownMessage$json = const {
  '1': 'UpDownMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'cid', '3': 2, '4': 1, '5': 4, '10': 'cid'},
    const {'1': 'fromUid', '3': 3, '4': 1, '5': 9, '10': 'fromUid'},
    const {'1': 'targetUid', '3': 4, '4': 1, '5': 9, '10': 'targetUid'},
    const {'1': 'groupId', '3': 5, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'conversationId', '3': 6, '4': 1, '5': 9, '10': 'conversationId'},
    const {'1': 'conversationType', '3': 7, '4': 1, '5': 14, '6': '.com.snow.proto.message.ConversationType', '10': 'conversationType'},
    const {'1': 'content', '3': 8, '4': 1, '5': 11, '6': '.com.snow.proto.message.MessageContent', '10': 'content'},
  ],
};

const HeartBeat$json = const {
  '1': 'HeartBeat',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'heartBeatType', '3': 2, '4': 1, '5': 14, '6': '.com.snow.proto.message.HeartBeatType', '10': 'heartBeatType'},
  ],
};

const MessageAck$json = const {
  '1': 'MessageAck',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'cid', '3': 2, '4': 1, '5': 4, '10': 'cid'},
    const {'1': 'targetUid', '3': 3, '4': 1, '5': 9, '10': 'targetUid'},
    const {'1': 'conversationId', '3': 4, '4': 1, '5': 9, '10': 'conversationId'},
    const {'1': 'time', '3': 5, '4': 1, '5': 4, '10': 'time'},
    const {'1': 'code', '3': 6, '4': 1, '5': 14, '6': '.com.snow.proto.message.Code', '10': 'code'},
  ],
};

const MessageContent$json = const {
  '1': 'MessageContent',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'uid', '3': 2, '4': 1, '5': 9, '10': 'uid'},
    const {'1': 'type', '3': 3, '4': 1, '5': 9, '10': 'type'},
    const {'1': 'content', '3': 4, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'time', '3': 5, '4': 1, '5': 4, '10': 'time'},
  ],
};

const HisMessagesReq$json = const {
  '1': 'HisMessagesReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'conversationId', '3': 2, '4': 1, '5': 9, '10': 'conversationId'},
    const {'1': 'beginId', '3': 3, '4': 1, '5': 4, '10': 'beginId'},
  ],
};

const HisMessagesAck$json = const {
  '1': 'HisMessagesAck',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'conversationId', '3': 2, '4': 1, '5': 9, '10': 'conversationId'},
    const {'1': 'convType', '3': 3, '4': 1, '5': 14, '6': '.com.snow.proto.message.ConversationType', '10': 'convType'},
    const {'1': 'messageList', '3': 4, '4': 3, '5': 11, '6': '.com.snow.proto.message.MessageContent', '10': 'messageList'},
    const {'1': 'unReadCount', '3': 5, '4': 1, '5': 4, '10': 'unReadCount'},
  ],
};

const ConversationReq$json = const {
  '1': 'ConversationReq',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.com.snow.proto.message.OperationType', '10': 'type'},
    const {'1': 'conversationId', '3': 3, '4': 1, '5': 9, '10': 'conversationId'},
  ],
};

const ConversationAck$json = const {
  '1': 'ConversationAck',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'code', '3': 3, '4': 1, '5': 14, '6': '.com.snow.proto.message.Code', '10': 'code'},
    const {'1': 'time', '3': 4, '4': 1, '5': 4, '10': 'time'},
    const {'1': 'conversationInfo', '3': 5, '4': 1, '5': 11, '6': '.com.snow.proto.message.ConversationInfo', '10': 'conversationInfo'},
    const {'1': 'conversationList', '3': 6, '4': 3, '5': 11, '6': '.com.snow.proto.message.ConversationInfo', '10': 'conversationList'},
  ],
};

const ConversationInfo$json = const {
  '1': 'ConversationInfo',
  '2': const [
    const {'1': 'conversationId', '3': 1, '4': 1, '5': 9, '10': 'conversationId'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.com.snow.proto.message.ConversationType', '10': 'type'},
    const {'1': 'uidList', '3': 3, '4': 3, '5': 9, '10': 'uidList'},
    const {'1': 'groupId', '3': 4, '4': 1, '5': 9, '10': 'groupId'},
    const {'1': 'readMsgId', '3': 5, '4': 1, '5': 4, '10': 'readMsgId'},
    const {'1': 'lastContent', '3': 6, '4': 1, '5': 11, '6': '.com.snow.proto.message.MessageContent', '10': 'lastContent'},
    const {'1': 'time', '3': 7, '4': 1, '5': 4, '10': 'time'},
  ],
};

const NotifyMessage$json = const {
  '1': 'NotifyMessage',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 4, '10': 'id'},
    const {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.com.snow.proto.message.NotifyType', '10': 'type'},
    const {'1': 'targetUid', '3': 3, '4': 1, '5': 9, '10': 'targetUid'},
    const {'1': 'conversationId', '3': 4, '4': 1, '5': 9, '10': 'conversationId'},
    const {'1': 'convType', '3': 5, '4': 1, '5': 14, '6': '.com.snow.proto.message.ConversationType', '10': 'convType'},
    const {'1': 'content', '3': 6, '4': 1, '5': 9, '10': 'content'},
    const {'1': 'time', '3': 7, '4': 1, '5': 4, '10': 'time'},
    const {'1': 'fromUid', '3': 8, '4': 1, '5': 9, '10': 'fromUid'},
  ],
};

