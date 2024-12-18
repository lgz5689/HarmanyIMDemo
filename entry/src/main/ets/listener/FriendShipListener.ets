import { proto, listener } from "imsdk";

export class FriendShipListener implements listener.FriendShipListener {
  onFriendApplicationAdded(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onFriendApplicationDeleted(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onFriendApplicationAccepted(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onFriendApplicationRejected(friendApplication: proto.sdk.shared.IIMFriendApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onFriendAdded(friendInfo: proto.sdk.shared.IIMFriend | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onFriendDeleted(friendInfo: proto.sdk.shared.IIMFriend | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onFriendInfoChanged(friendInfo: proto.sdk.shared.IIMFriend | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onBlackAdded(blackInfo: proto.sdk.shared.IIMBlack | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onBlackDeleted(blackInfo: proto.sdk.shared.IIMBlack | null | undefined): void {
    throw new Error("Method not implemented.");
  }
}