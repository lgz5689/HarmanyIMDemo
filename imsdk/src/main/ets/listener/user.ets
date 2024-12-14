import { openim } from "../proto/proto"

export interface IUserListener {
  onSelfInfoUpdated(user: openim.sdk.shared.IMUser): void;

  onUserCommandAdd(command: openim.sdk.shared.CommandInfo): void;

  onUserCommandDelete(command: openim.sdk.shared.CommandInfo): void;

  onUserCommandUpdate(command: openim.sdk.shared.CommandInfo): void;
}

