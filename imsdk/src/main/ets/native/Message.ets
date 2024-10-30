export enum MessageDef {
  Error,

  Connecting,
  ConnectSuccess,
  ConnectFailed,
  KickedOffline,
  UserTokenExpired,
  UserTokenInvalid,

  SyncServerStart,
  SyncServerFinish,
  SyncServerProgress,
  SyncServerFailed,
  NewConversation,
  ConversationChanged,
  TotalUnreadMessageCountChanged,
  ConversationUserInputStatusChanged,

  Advanced_RecvNewMessage,
  Advanced_RecvC2CReadReceipt,
  Advanced_RecvGroupReadReceipt,
  Advanced_NewRecvMessageRevoked,
  Advanced_RecvMessageExtensionsChanged,
  Advanced_RecvMessageExtensionsDeleted,
  Advanced_RecvMessageExtensionsAdded,
  Advanced_RecvOfflineNewMessage,
  Advanced_MsgDeleted,
  Advanced_RecvOnlineOnlyMessage,

  Batch_RecvNewMessages,
  Batch_RecvOfflineNewMessages,

  FriendApplicationAdded,
  FriendApplicationDeleted,
  FriendApplicationAccepted,
  FriendApplicationRejected,
  FriendAdded,
  FriendDeleted,
  FriendInfoChanged,
  BlackAdded,
  BlackDeleted,

  JoinedGroupAdded,
  JoinedGroupDeleted,
  GroupMemberAdded,
  GroupMemberDeleted,
  GroupApplicationAdded,
  GroupApplicationDeleted,
  GroupInfoChanged,
  GroupDismissed,
  GroupMemberInfoChanged,
  GroupApplicationAccepted,
  GroupApplicationRejected,

  RecvCustomBusinessMessage,

  SelfInfoUpdated,
  UserStatusChanged,
  UserCommandAdd,
  UserCommandDelete,
  UserCommandUpdate,

  SendMessage_Error,
  SendMessage_Success,
  SendMessage_Progress,

  ActiveCall
}