import { proto, listener } from "imsdk";

export class GroupListener implements listener.GroupListener {
  onJoinedGroupAdded(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onJoinedGroupDeleted(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupMemberAdded(groupMemberInfo: proto.sdk.shared.IIMGroupMember | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupMemberDeleted(groupMemberInfo: proto.sdk.shared.IIMGroupMember | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupApplicationAdded(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupApplicationDeleted(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupInfoChanged(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupDismissed(groupInfo: proto.sdk.shared.IIMGroup | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupMemberInfoChanged(groupMemberInfo: proto.sdk.shared.IIMGroupMember | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupApplicationAccepted(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }

  onGroupApplicationRejected(groupApplication: proto.sdk.shared.IIMGroupApplication | null | undefined): void {
    throw new Error("Method not implemented.");
  }
}