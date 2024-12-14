import { openim } from "../proto/proto"

export interface IGroupListener {
  onJoinedGroupAdded(groupInfo: openim.sdk.shared.IMGroup): void;

  onJoinedGroupDeleted(groupInfo: openim.sdk.shared.IMGroup): void;

  onGroupMemberAdded(groupMemberInfo: openim.sdk.shared.IMGroupMember): void;

  onGroupMemberDeleted(groupMemberInfo: openim.sdk.shared.IMGroupMember): void;

  onGroupApplicationAdded(groupApplication: openim.sdk.shared.IMGroupApplication): void;

  onGroupApplicationDeleted(groupApplication: openim.sdk.shared.IMGroupApplication): void;

  onGroupInfoChanged(groupInfo: openim.sdk.shared.IMGroup): void;

  onGroupDismissed(groupInfo: openim.sdk.shared.IMGroup): void;

  onGroupMemberInfoChanged(groupMemberInfo: openim.sdk.shared.IMGroupMember): void;

  onGroupApplicationAccepted(groupApplication: openim.sdk.shared.IMGroupApplication): void;

  onGroupApplicationRejected(groupApplication: openim.sdk.shared.IMGroupApplication): void;
}

