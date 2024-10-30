import {
  BlackInfo,
  Conversation,
  FriendApplicationInfo,
  FriendInfo,
  GroupApplicationInfo,
  GroupInfo,
  GroupMember,
  InputStatesChangedData,
  Message,
  MessageReceipt,
  MessageRevoked,
  OnlineStatus,
  UserInfo
} from "./Data";

export interface IConnListener {
  onConnecting(): void;

  onConnectSuccess(): void;

  onConnectFailed(errCode: number, errMsg: string): void;

  onKickedOffline(): void;

  onUserTokenExpired(): void;

  onUserTokenInvalid(errMsg: string): void;
}

export interface IConversationListener {
  onSyncServerStart(): void;

  onSyncServerFinish(): void;

  onSyncServerProgress(progress: number): void;

  onSyncServerFailed(): void;

  onNewConversation(conversationList: Conversation[]): void;

  onConversationChanged(conversationList: Conversation[]): void;

  onTotalUnreadMessageCountChanged(totalUnreadCount: number): void;

  onConversationUserInputStatusChanged(data: InputStatesChangedData): void;
}

export interface IFriendShipListener {
  onFriendApplicationAdded(friendApplication: FriendApplicationInfo): void;

  onFriendApplicationDeleted(friendApplication: FriendApplicationInfo): void;

  onFriendApplicationAccepted(friendApplication: FriendApplicationInfo): void;

  onFriendApplicationRejected(friendApplication: FriendApplicationInfo): void;

  onFriendAdded(friendInfo: FriendInfo): void;

  onFriendDeleted(friendInfo: FriendInfo): void;

  onFriendInfoChanged(friendInfo: FriendInfo): void;

  onBlackAdded(blackInfo: BlackInfo): void;

  onBlackDeleted(blackInfo: BlackInfo): void;
}

export interface IGroupListener {
  onJoinedGroupAdded(groupInfo: GroupInfo): void;

  onJoinedGroupDeleted(groupInfo: GroupInfo): void;

  onGroupMemberAdded(groupMemberInfo: GroupMember): void;

  onGroupMemberDeleted(groupMemberInfo: GroupMember): void;

  onGroupApplicationAdded(groupApplication: GroupApplicationInfo): void;

  onGroupApplicationDeleted(groupApplication: GroupApplicationInfo): void;

  onGroupInfoChanged(groupInfo: GroupInfo): void;

  onGroupDismissed(groupInfo: GroupInfo): void;

  onGroupMemberInfoChanged(groupMemberInfo: GroupMember): void;

  onGroupApplicationAccepted(groupApplication: GroupApplicationInfo): void;

  onGroupApplicationRejected(groupApplication: GroupApplicationInfo): void;
}

export interface IUserListener {
  onSelfInfoUpdated(userInfo: UserInfo): void;

  onUserStatusChanged(userOnlineStatus: OnlineStatus): void;

  onUserCommandAdd(userCommand: string): void;

  onUserCommandDelete(userCommand: string): void;

  onUserCommandUpdate(userCommand: string): void;
}

export interface IAdvancedMsgListener {
  onRecvNewMessage(message: Message): void;

  onRecvC2CReadReceipt(msgReceiptList: MessageReceipt[]): void;

  onRecvGroupReadReceipt(groupMsgReceiptList: MessageReceipt[]): void;

  onNewRecvMessageRevoked(messageRevoked: MessageRevoked): void;

  onRecvMessageExtensionsChanged(msgID: string, reactionExtensionList: string): void;

  onRecvMessageExtensionsDeleted(msgID: string, reactionExtensionKeyList: string): void;

  onRecvMessageExtensionsAdded(msgID: string, reactionExtensionList: string): void;

  onRecvOfflineNewMessage(message: Message): void;

  onMsgDeleted(message: Message): void;

  onRecvOnlineOnlyMessage(message: Message): void;
}

export interface IBatchMsgListener {
  onRecvNewMessages(messageList: Message[]): void;

  onRecvOfflineNewMessages(messageList: Message[]): void;
}