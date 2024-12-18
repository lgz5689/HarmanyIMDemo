import { proto, listener } from "imsdk";

export class UserListener implements listener.UserListener {
  onSelfInfoUpdated(user: proto.sdk.shared.IIMUser | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onUserOnlineStatusChanged(userId: string, platforms: proto.sdk.common.Platform[]): void {
    throw new Error("Method not implemented.");
  }

  onUserCommandAdd(command: proto.sdk.shared.ICommandInfo | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onUserCommandDelete(command: proto.sdk.shared.ICommandInfo | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onUserCommandUpdate(command: proto.sdk.shared.ICommandInfo | null | undefined): void {
    throw new Error("Method not implemented.");
  }
}