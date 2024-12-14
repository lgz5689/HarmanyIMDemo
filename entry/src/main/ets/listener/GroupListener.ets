// import { GroupApplicationInfo, GroupInfo, GroupMember, IGroupListener } from "imsdk";
//
// export class GroupListener implements IGroupListener {
//   onJoinedGroupAdded(groupInfo: GroupInfo): void{
//     console.error('==========================onJoinedGroupAdded',JSON.stringify(groupInfo))
//   };
//
//   onJoinedGroupDeleted(groupInfo: GroupInfo): void{
//     console.error('==========================onJoinedGroupDeleted',JSON.stringify(groupInfo))
//   };
//
//   onGroupMemberAdded(groupMemberInfo: GroupMember): void{
//     console.error('==========================onGroupMemberAdded',JSON.stringify(groupMemberInfo))
//   };
//
//   onGroupMemberDeleted(groupMemberInfo: GroupMember): void{
//     console.error('==========================onGroupMemberDeleted',JSON.stringify(groupMemberInfo))
//   };
//
//   onGroupApplicationAdded(groupApplication: GroupApplicationInfo): void{
//     console.error('==========================onGroupApplicationAdded',JSON.stringify(groupApplication))
//   };
//
//   onGroupApplicationDeleted(groupApplication: GroupApplicationInfo): void{
//     console.error('==========================onGroupApplicationDeleted',JSON.stringify(groupApplication))
//   };
//
//   onGroupInfoChanged(groupInfo: GroupInfo): void{
//     console.error('==========================onGroupInfoChanged',JSON.stringify(groupInfo))
//   };
//
//   onGroupDismissed(groupInfo: GroupInfo): void{
//     console.error('==========================onGroupDismissed',JSON.stringify(groupInfo))
//   };
//
//   onGroupMemberInfoChanged(groupMemberInfo: GroupMember): void{
//     console.error('==========================onGroupMemberInfoChanged',JSON.stringify(groupMemberInfo))
//   };
//
//   onGroupApplicationAccepted(groupApplication: GroupApplicationInfo): void{
//     console.error('==========================onGroupApplicationAccepted',JSON.stringify(groupApplication))
//   };
//
//   onGroupApplicationRejected(groupApplication: GroupApplicationInfo): void{
//     console.error('==========================onGroupApplicationRejected',JSON.stringify(groupApplication))
//   };
// }