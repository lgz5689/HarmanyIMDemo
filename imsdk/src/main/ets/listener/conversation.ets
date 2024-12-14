import { openim } from "../proto/proto"

export interface IConversationListener {
  onSyncServerStart(): void;

  onSyncServerFinish(): void;

  onSyncServerProgress(progress: number): void;

  onSyncServerFailed(): void;

  onNewConversation(conversationList: openim.sdk.shared.IMConversation[]): void;

  onConversationChanged(conversationList: openim.sdk.shared.IMConversation[]): void;

  onTotalUnreadMessageCountChanged(totalUnreadCount: number): void;

  onConversationUserInputStatusChanged(): void;
}