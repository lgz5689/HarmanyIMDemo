import { proto, listener } from "imsdk";

export class MessageListener implements listener.MessageListener {
  onRecvNewMessage(message: proto.sdk.shared.IIMMessage | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onRecvC2CReadReceipt(msgReceiptList: proto.event.IMessageReceipt[]): void {
    throw new Error("Method not implemented.");
  }

  onNewRecvMessageRevoked(revokedTips: proto.sdk.shared.IRevokedTips | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onRecvOfflineNewMessage(message: proto.sdk.shared.IIMMessage | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onMessageDeleted(message: proto.sdk.shared.IIMMessage | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onRecvOnlineOnlyMessage(message: proto.sdk.shared.IIMMessage | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onMessageEdited(message: proto.sdk.shared.IIMMessage | null | undefined): void {
    throw new Error("Method not implemented.");
  }
}