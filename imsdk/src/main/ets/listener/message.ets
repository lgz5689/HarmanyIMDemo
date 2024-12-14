import { openim } from "../proto/proto"

export interface MessageListener {
  onRecvNewMessage(message: openim.sdk.shared.IMMessage): void;

  onRecvC2CReadReceipt(): void;

  onRecvGroupReadReceipt(): void;

  onNewRecvMessageRevoked(): void;

}

