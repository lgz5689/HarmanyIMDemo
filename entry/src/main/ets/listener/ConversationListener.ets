import { proto, listener } from "imsdk";

export class ConversationListener implements listener.ConversationListener {
  onSyncServerStart(reinstalled: boolean): void {
    throw new Error("Method not implemented.");
  }

  onSyncServerFinish(reinstalled: boolean): void {
    throw new Error("Method not implemented.");
  }

  onSyncServerProgress(progress: number): void {
    throw new Error("Method not implemented.");
  }

  onSyncServerFailed(reinstalled: boolean): void {
    throw new Error("Method not implemented.");
  }

  onNewConversation(conversationList: proto.sdk.shared.IIMConversation[]): void {
    throw new Error("Method not implemented.");
  }

  onConversationChanged(conversationList: proto.sdk.shared.IIMConversation[]): void {
    throw new Error("Method not implemented.");
  }

  onTotalUnreadMessageCountChanged(totalUnreadCount: number): void {
    throw new Error("Method not implemented.");
  }

  onConversationUserInputStatusChanged(conversationId: string, userId: string,
    platforms: proto.sdk.common.Platform[]): void {
    throw new Error("Method not implemented.");
  }
}