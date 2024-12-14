import { openim } from "../proto/proto"

export interface FriendShipListener {
  onFriendApplicationAdded(friendApplication: openim.sdk.shared.IMFriendApplication): void;

  onFriendApplicationDeleted(friendApplication: openim.sdk.shared.IMFriendApplication): void;

  onFriendApplicationAccepted(friendApplication: openim.sdk.shared.IMFriendApplication): void;

  onFriendApplicationRejected(friendApplication: openim.sdk.shared.IMFriendApplication): void;

  onFriendAdded(friendInfo: openim.sdk.shared.IMFriend): void;

  onFriendDeleted(friendInfo: openim.sdk.shared.IMFriend): void;

  onFriendInfoChanged(friendInfo: openim.sdk.shared.IMFriend): void;

  onBlackAdded(blackInfo: openim.sdk.shared.IMBlack): void;

  onBlackDeleted(blackInfo: openim.sdk.shared.IMBlack): void;
}