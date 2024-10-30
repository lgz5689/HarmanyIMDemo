import { ConversationType, GroupMemberFilter } from "./Enum"

export interface BaseArgs {
  operationId: string
}

export interface InitSDKArgs {
  operationId: string
  config: string
}

export interface LoginArgs {
  operationId: string
  uid: string
  token: string
}

export interface SetAppBackgroundStatusArgs {
  operationId: string
  isBackground: boolean
}

export interface CreateTextMessageArgs {
  operationId: string
  text: string
}

export interface CreateAdvancedTextMessageArgs {
  operationId: string
  text: string
  messageEntityList: string
}

export interface CreateTextAtMessageArgs {
  operationId: string
  text,
  atUserList: string,
  atUsersInfo: string,
  message: string,
}

export interface CreateLocationMessageArgs {
  operationId: string
  description: string;
  longitude: number;
  latitude: number;
}

export interface CreateCustomMessageArgs {
  operationId: string;
  data: string;
  extension: string;
  description: string;
}

export interface CreateQuoteMessageArgs {
  operationId: string;
  text: string;
  message: string;
}

export interface CreateAdvancedQuoteMessageArgs {
  operationId: string;
  text: string;
  message: string;
  messageEntityList: string;
}

export interface CreateCardMessageArgs {
  operationId: string;
  cardInfo: string;
}

export interface CreateVideoMessageFromFullPathArgs {
  operationId: string;
  videoFullPath: string;
  videoType: string;
  duration: number;
  snapshotFullPath: string;
}

export interface CreateImageMessageFromFullPathArgs {
  operationId: string;
  imageFullPath: string;
}

export interface CreateSoundMessageFromFullPathArgs {
  operationId: string;
  soundPath: string;
  duration: number;
}

export interface CreateFileMessageFromFullPathArgs {
  operationId: string;
  fileFullPath: string;
  fileName: string;
}

export interface CreateImageMessageArgs {
  operationId: string;
  imagePath: string;
}

export interface CreateImageMessageByURLArgs {
  operationId: string;
  sourcePath: string;
  sourcePicture: string;
  bigPicture: string;
  snapshotPicture: string;
}

export interface CreateSoundMessageByURLArgs {
  operationId: string;
  soundBaseInfo: string;
}

export interface CreateVideoMessageByURLArgs {
  operationId: string;
  videoBaseInfo: string;
}

export interface CreateVideoMessageArgs {
  operationId: string;
  videoPath: string;
  videoType: string;
  duration: number;
  snapshotPath: string;
}

export interface CreateFileMessageByURLArgs {
  operationId: string;
  fileBaseInfo: string;
}

export interface CreateFileMessageArgs {
  operationId: string;
  filePath: string;
  fileName: string;
}

export interface CreateMergerMessageArgs {
  operationId: string;
  messageList: string;
  title: string;
  summaryList: string;
}

export interface CreateFaceMessageArgs {
  operationId: string;
  index: number;
  data: string;
}

export interface CreateForwardMessageArgs {
  operationId: string;
  message: string;
}

export interface GetConversationListSplitArgs {
  operationId: string;
  offset: number;
  count: number;
}

export interface GetOneConversationArgs {
  operationId: string;
  sessionType: ConversationType;
  sourceId: string;
}

export interface GetMultipleConversationArgs {
  operationId: string;
  conversationIdList: string;
}

export interface HideConversationArgs {
  operationId: string;
  conversationId: string;
}

export interface SetConversationArgs {
  operationId: string;
  conversationId: string;
  req: string;
}

export interface SetConversationDraftArgs {
  operationId: string;
  conversationId: string;
  draftText: string;
}

export interface GetConversationIdBySessionTypeArgs {
  operationId: string;
  sourceId: string;
  sessionType: number;
}

export interface SendMessageArgs {
  operationId: string;
  message: string;
  recvId: string;
  groupId: string;
  offlinePushInfo: string;
  isOnlineOnly: boolean;
}

export interface SendMessageNotOSSArgs {
  operationId: string;
  message: string;
  recvId: string;
  groupId: string;
  offlinePushInfo: string;
  isOnlineOnly: boolean;
}

export interface FindMessageListArgs {
  operationId: string;
  findMessageOptions: string; // 假设这里是 JSON 字符串
}

export interface GetAdvancedHistoryMessageListArgs {
  operationId: string;
  getMessageOptions: string; // 假设这里是 JSON 字符串
}

export interface GetAdvancedHistoryMessageListReverseArgs {
  operationId: string;
  getMessageOptions: string; // 假设这里是 JSON 字符串
}

export interface RevokeMessageArgs {
  operationId: string;
  conversationId: string;
  clientMsgId: string;
}

export interface TypingStatusUpdateArgs {
  operationId: string;
  recvId: string;
  msgTip: string;
}

export interface MarkConversationMessageAsReadArgs {
  operationId: string;
  conversationId: string;
}

export interface DeleteMessageFromLocalStorageArgs {
  operationId: string;
  conversationId: string;
  clientMsgId: string;
}

export interface DeleteMessageArgs {
  operationId: string;
  conversationId: string;
  clientMsgId: string;
}

export interface HideAllConversationsArgs {
  operationId: string;
}

export interface DeleteAllMsgFromLocalAndSVRArgs {
  operationId: string;
}

export interface DeleteAllMsgFromLocalArgs {
  operationId: string;
}

export interface ClearConversationAndDeleteAllMsgArgs {
  operationId: string;
  conversationId: string;
}

export interface DeleteConversationAndDeleteAllMsgArgs {
  operationId: string;
  conversationId: string;
}

export interface InsertSingleMessageToLocalStorageArgs {
  operationId: string;
  message: string; // 假设这里是 JSON 字符串
  recvId: string;
  sendId: string;
}

export interface InsertGroupMessageToLocalStorageArgs {
  operationId: string;
  message: string; // 假设这里是 JSON 字符串
  groupId: string;
  sendId: string;
}

export interface SearchLocalMessagesArgs {
  operationId: string;
  searchParam: string; // 假设这里是 JSON 字符串
}

export interface SetMessageLocalExArgs {
  operationId: string;
  conversationId: string;
  clientMsgId: string;
  localEx: string;
}

export interface GetUsersInfoArgs {
  operationId: string;
  userIds: string; // 假设这里是 JSON 字符串
}

export interface SetSelfInfoArgs {
  operationId: string;
  userInfo: string; // 假设这里是 JSON 字符串
}

export interface SubscribeUsersStatusArgs {
  operationId: string;
  userIds: string; // 假设这里是 JSON 字符串
}

export interface UnsubscribeUsersStatusArgs {
  operationId: string;
  userIds: string; // 假设这里是 JSON 字符串
}

export interface GetUserStatusArgs {
  operationId: string;
  userIds: string;
}

export interface GetSpecifiedFriendsInfoArgs {
  operationId: string;
  userIdList: string;
  filterBlack: boolean;
}

export interface GetFriendListArgs {
  operationId: string;
  filterBlack: boolean;
}

export interface GetFriendListPageArgs {
  operationId: string;
  offset: number;
  count: number;
  filterBlack: boolean;
}

export interface SearchFriendsArgs {
  operationId: string;
  searchParam: string;
}

export interface UpdateFriendsArgs {
  operationId: string;
  req: string;
}

export interface CheckFriendArgs {
  operationId: string;
  userIdList: string;
}

export interface AddFriendArgs {
  operationId: string;
  userIdReqMsg: string;
}

export interface DeleteFriendArgs {
  operationId: string;
  friendUserId: string;
}

export interface GetFriendApplicationListAsRecipientArgs {
  operationId: string;
}

export interface GetFriendApplicationListAsApplicantArgs {
  operationId: string;
}

export interface AcceptFriendApplicationArgs {
  operationId: string;
  userIdHandleMsg: string;
}

export interface RefuseFriendApplicationArgs {
  operationId: string;
  userIdHandleMsg: string;
}

export interface AddBlackArgs {
  operationId: string;
  blackUserId: string;
  ex: string;
}

export interface GetBlackListArgs {
  operationId: string;
}

export interface RemoveBlackArgs {
  operationId: string;
  removeUserId: string;
}

export interface CreateGroupArgs {
  operationId: string;
  groupReqInfo: string;
}

export interface JoinGroupArgs {
  operationId: string;
  groupId: string;
  reqMsg: string;
  joinSource: number; // Assuming JoinSource is a number enum
  ex: string;
}

export interface QuitGroupArgs {
  operationId: string;
  groupId: string;
}

export interface DismissGroupArgs {
  operationId: string;
  groupId: string;
}

export interface ChangeGroupMuteArgs {
  operationId: string;
  groupId: string;
  isMute: boolean;
}

export interface ChangeGroupMemberMuteArgs {
  operationId: string;
  groupId: string;
  userId: string;
  mutedSeconds: number;
}

export interface SetGroupMemberInfoArgs {
  operationId: string;
  groupMemberInfo: string;
}

export interface GetJoinedGroupListArgs {
  operationId: string;
}

export interface GetJoinedGroupListPageArgs {
  operationId: string;
  offset: number;
  count: number;
}

export interface GetSpecifiedGroupsInfoArgs {
  operationId: string;
  groupIdList: string;
}

export interface SearchGroupsArgs {
  operationId: string;
  searchParam: string;
}

export interface SetGroupInfoArgs {
  operationId: string;
  groupInfo: string;
}

export interface GetGroupMemberListArgs {
  operationId: string;
  groupId: string;
  filter: GroupMemberFilter; // Assuming GroupMemberFilter is defined elsewhere
  offset: number;
  count: number;
}

export interface GetGroupMemberOwnerAndAdminArgs {
  operationId: string;
  groupId: string;
}

export interface GetGroupMemberListByJoinTimeFilterArgs {
  operationId: string;
  groupId: string;
  offset: number;
  count: number;
  joinTimeBegin: number;
  joinTimeEnd: number;
  filterUserIdList: string;
}

export interface GetSpecifiedGroupMembersInfoArgs {
  operationId: string;
  groupId: string;
  userIdList: string;
}

export interface KickGroupMemberArgs {
  operationId: string;
  groupId: string;
  reason: string;
  userIdList: string;
}

export interface TransferGroupOwnerArgs {
  operationId: string;
  groupId: string;
  newOwnerUserId: string;
}

export interface InviteUserToGroupArgs {
  operationId: string;
  groupId: string;
  reason: string;
  userIdList: string;
}

export interface GetGroupApplicationListAsRecipientArgs {
  operationId: string;
}

export interface GetGroupApplicationListAsApplicantArgs {
  operationId: string;
}

export interface AcceptGroupApplicationArgs {
  operationId: string;
  groupId: string;
  fromUserId: string;
  handleMsg: string;
}

export interface RefuseGroupApplicationArgs {
  operationId: string;
  groupId: string;
  fromUserId: string;
  handleMsg: string;
}

export interface SearchGroupMembersArgs {
  operationId: string;
  searchParam: string;
}

export interface IsJoinGroupArgs {
  operationId: string;
  groupId: string;
}

export interface GetUsersInGroupArgs {
  operationId: string;
  groupId: string;
  userIdList: string[];
}
