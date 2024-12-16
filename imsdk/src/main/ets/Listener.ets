import { openim as proto } from "./proto/proto"

export namespace listener {
  export interface ConnListener {
    onConnecting(): void;

    onConnectSuccess(): void;

    onConnectFailed(errCode: number, errMsg: string): void;

    onKickedOffline(): void;

    onUserTokenExpired(): void;

    onUserTokenInvalid(errMsg: string): void;
  }

  export interface ConversationListener {
    onSyncServerStart(reinstalled: boolean): void;

    onSyncServerFinish(reinstalled: boolean): void;

    onSyncServerProgress(progress: number): void;

    onSyncServerFailed(reinstalled: boolean): void;

    onNewConversation(conversationList: proto.sdk.shared.IIMConversation[]): void;

    onConversationChanged(conversationList: proto.sdk.shared.IIMConversation[]): void;

    onTotalUnreadMessageCountChanged(totalUnreadCount: number): void;

    onConversationUserInputStatusChanged(conversationId: string, userId: string,
      platforms: proto.sdk.common.Platform[]): void;
  }

  export interface FriendShipListener {
    onFriendApplicationAdded(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void;

    onFriendApplicationDeleted(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void;

    onFriendApplicationAccepted(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void;

    onFriendApplicationRejected(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void;

    onFriendAdded(friendInfo: proto.sdk.shared.IIMFriend | null | undefined): void;

    onFriendDeleted(friendInfo: proto.sdk.shared.IIMFriend | null | undefined): void;

    onFriendInfoChanged(friendInfo: proto.sdk.shared.IIMFriend | null | undefined): void;

    onBlackAdded(blackInfo: proto.sdk.shared.IIMBlack | null | undefined): void;

    onBlackDeleted(blackInfo: proto.sdk.shared.IIMBlack | null | undefined): void;
  }

  export interface GroupListener {
    onJoinedGroupAdded(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void;

    onJoinedGroupDeleted(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void;

    onGroupMemberAdded(groupMemberInfo: proto.sdk.shared.IIMGroupMember | null | undefined): void;

    onGroupMemberDeleted(groupMemberInfo: proto.sdk.shared.IIMGroupMember | null | undefined): void;

    onGroupApplicationAdded(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void;

    onGroupApplicationDeleted(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void;

    onGroupInfoChanged(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void;

    onGroupDismissed(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void;

    onGroupMemberInfoChanged(groupMemberInfo: proto.sdk.shared.IIMGroupMember | null | undefined): void;

    onGroupApplicationAccepted(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void;

    onGroupApplicationRejected(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void;
  }


  export interface MessageListener {
    onRecvNewMessage(message: proto.sdk.shared.IIMMessage | null | undefined): void;

    onRecvC2CReadReceipt(msgReceiptList: proto.event.IMessageReceipt[]): void;

    onNewRecvMessageRevoked(revokedTips: proto.sdk.shared.IRevokedTips | null | undefined): void;

    onRecvOfflineNewMessage(message: proto.sdk.shared.IIMMessage | null | undefined): void;

    onMessageDeleted(message: proto.sdk.shared.IIMMessage | null | undefined): void;

    onRecvOnlineOnlyMessage(message: proto.sdk.shared.IIMMessage | null | undefined): void;

    onMessageEdited(message: proto.sdk.shared.IIMMessage | null | undefined): void;
  }

  export interface UserListener {
    onSelfInfoUpdated(user: proto.sdk.shared.IIMUser | null | undefined): void;

    onUserOnlineStatusChanged(userId: string, platforms: proto.sdk.common.Platform[]): void;

    onUserCommandAdd(command: proto.sdk.shared.ICommandInfo | null | undefined): void;

    onUserCommandDelete(command: proto.sdk.shared.ICommandInfo | null | undefined): void;

    onUserCommandUpdate(command: proto.sdk.shared.ICommandInfo | null | undefined): void;
  }


  export interface ISendMsg {
    onError(errCode: number, errMsg: string): void;

    onSuccess(msg: proto.sdk.shared.IIMMessage | null | undefined): void;

    onProgress(progress: number): void;

  }

  export interface IUploadFile {
    onError(errCode: number, errMsg: string): void;

    onSuccess(url: string): void;

    onProgress(progress: number): void;
  }

  export interface IUploadLogs {
    onError(errCode: number, errMsg: string): void;

    onSuccess(): void;

    onProgress(progress: number): void;
  }
}