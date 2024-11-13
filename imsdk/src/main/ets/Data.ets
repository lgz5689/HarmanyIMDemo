import { GroupType, JoinSource, LogLevel, PlatformID } from "./Enum";

export interface BoolValue {
  value: boolean;
}

export interface StringValue {
  value: string;
}

export interface NumberValue {
  value: number;
}

export interface IMConfig {
  platformID: PlatformID;
  apiAddr: string;
  wsAddr: string;
  dataDir: string;
  logLevel: LogLevel;
  isLogStandardOutput: boolean;
  logFilePath: string;
  isExternalExtensions: boolean;
}

// user data info
export interface UserInfo {
  userID: string;
  nickname: string;
  faceURL: string;
  createTime: number;
  appMangerLevel: number;
  ex: string;
  attachedInfo: string;
  globalRecvMsgOpt: number;
}

export interface PublicUserInfo {
  userID: string;
  nickname: string;
  faceURL: string;
  ex: string;
  createTime: number;
}

export interface OnlineStatus {
  userID: string;
  status: number;
  platformIDs: number[];
}

export interface UserIDResult {
  userID: string;
  result: number;
}

// friend data info
export interface FriendInfo {
  ownerUserID: string;
  friendUserID: string;
  remark: string;
  createTime: number;
  addSource: number;
  operatorUserID: string;
  nickname: string;
  faceURL: string;
  ex: string;
  attachedInfo: string;
  isPinned: boolean;
}

export interface FriendApplicationInfo {
  fromUserID: string;
  fromNickname: string;
  fromFaceURL: string;
  toUserID: string;
  toNickname: string;
  toFaceURL: string;
  handleResult: number;
  reqMsg: string;
  createTime: number;
  handlerUserID: string;
  handleMsg: string;
  handleTime: number;
  ex: string;
  attachedInfo: string;
}

export interface BlackInfo {
  ownerUserID: string;
  blockUserID: string;
  nickname: string;
  faceURL: string;
  createTime: number;
  addSource: number;
  operatorUserID: string;
  ex: string;
  attachedInfo: string;
}

export interface SearchFriendsParam {
  keywordList: string[];
  isSearchUserID: boolean;
  isSearchNickname: boolean;
  isSearchRemark: boolean;
}

export interface ProcessFriendApplicationParams {
  toUserID: string;
  handleMsg: string;
}

export interface UpdateFriendsReq {
  friendUserIDs: string[];
  isPinned: BoolValue;
  remark: StringValue;
  ex: StringValue;
}

export interface SearchFriendItem extends FriendInfo {
  relationship: number;
}

export interface ApplyToAddFriendReq {
  fromUserID: string;
  toUserID: string;
  reqMsg: string;
  ex: string;
}

// group data info
export interface GroupHasReadInfo {
  hasReadUserIDList: string[];
  hasReadCount: number;
  groupMemberCount: number;
}

export interface GroupInfo {
  groupID: string;
  groupName: string;
  notification: string;
  introduction: string;
  faceURL: string;
  createTime: number;
  status: number;
  creatorUserID: string;
  groupType: number;
  ownerUserID: string;
  memberCount: number;
  ex: string;
  attachedInfo: string;
  needVerification: number;
  lookMemberInfo: number;
  applyMemberFriend: number;
  notificationUpdateTime: number;
  notificationUserID: string;
}

export interface GroupMember {
  groupID: string;
  userID: string;
  nickname: string;
  faceURL: string;
  roleLevel: number;
  joinTime: number;
  joinSource: number;
  inviterUserID: string;
  muteEndTime: number;
  operatorUserID: string;
  ex: string;
  attachedInfo: string;
}

export interface GroupApplicationInfo {
  groupID: string;
  groupName: string;
  notification: string;
  introduction: string;
  groupFaceURL: string;
  createTime: number;
  status: number;
  creatorUserID: string;
  groupType: GroupType;
  ownerUserID: string;
  memberCount: number;
  userID: string;
  nickname: string;
  userFaceURL: string;
  handleResult: number;
  reqMsg: string;
  handledMsg: string;
  reqTime: number;
  handleUserID: string;
  handledTime: number;
  ex: string;
  attachedInfo: string;
  joinSource: JoinSource;
  inviterUserID: string;
}

export interface SearchGroupsParam {
  keywordList: string[];
  isSearchGroupID: boolean;
  isSearchGroupName: boolean;
}

export interface SearchGroupMembersParam {
  groupID: string;
  keywordList: string[];
  isSearchUserID: boolean;
  isSearchMemberNickname: boolean;
  offset: number;
  count: number;
}

export interface GroupMemberInfoArgs {
  groupID: string;
  userID: string;
  nickname: StringValue;
  faceURL: StringValue;
  roleLevel: NumberValue;
  ex: StringValue;
}

export interface GroupInfoForSet {
  groupID: string;
  groupName: string;
  notification: string;
  introduction: string;
  faceURL: string;
  ex: StringValue;
  needVerification: NumberValue;
  lookMemberInfo: NumberValue;
  applyMemberFriend: NumberValue;
}

export interface CreateGroupReq {
  memberUserIDs: string[];
  groupInfo: Partial<GroupInfo>;
  adminUserIDs: string[];
  ownerUserID: string;
}

// conversation data info
export interface Conversation {
  conversationID: string;
  conversationType: number;
  userID: string;
  groupID: string;
  showName: string;
  faceURL: string;
  recvMsgOpt: number;
  unreadCount: number;
  groupAtType: number;
  latestMsg: string;
  latestMsgSendTime: number;
  draftText: string;
  draftTextTime: number;
  isPinned: boolean;
  isPrivateChat: boolean;
  burnDuration: number;
  isNotInGroup: boolean;
  updateUnreadCountTime: number;
  attachedInfo: string;
  ex: string;
  maxSeq: number;
  minSeq: number;
  hasReadSeq: number;
  msgDestructTime: number;
  isMsgDestruct: boolean;
}

export interface ConversationArgs {
  conversationID: string;
  clientMsgIDList: string[];
}

export interface ConversationReq {
  recvMsgOpt: NumberValue;
  isPinned: BoolValue;
  isPrivateChat: BoolValue;
  ex: StringValue;
  burnDuration: NumberValue;
  groupAtType: NumberValue;
}

export interface InputStatesChangedData {
  conversationID: string;
  userID: string;
  platformIDs: number[];
}

// message data info

export interface MessageReceipt {
  groupID: string;
  userID: string;
  msgIDList: string[];
  readTime: number;
  msgFrom: number;
  contentType: number;
  sessionType: number;
}

export interface MessageRevoked {
  revokerID: string;
  revokerRole: number;
  clientMsgID: string;
  revokerNickname: string;
  revokeTime: number;
  sourceMessageSendTime: number;
  sourceMessageSendID: string;
  sourceMessageSenderNickname: string;
  sessionType: number;
  seq: number;
  ex: string;
  isAdminRevoke: boolean;
}

export interface PictureBaseInfo {
  uuid: string;
  type: string;
  size: number;
  width: number;
  height: number;
  url: string;
}

export interface TextElem {
  content: string;
}

export interface CardElem {
  userID: string;
  nickname: string;
  faceURL: string;
  ex: string;
}

export interface PictureElem {
  sourcePath: string;
  sourcePicture: PictureBaseInfo;
  bigPicture: PictureBaseInfo;
  snapshotPicture: PictureBaseInfo;
}

export interface SoundElem {
  uuid: string;
  soundPath: string;
  sourceUrl: string;
  dataSize: number;
  duration: number;
  soundType: string;
}

export interface VideoElem {
  videoPath: string;
  videoUUID: string;
  videoUrl: string;
  videoType: string;
  videoSize: number;
  duration: number;
  snapshotPath: string;
  snapshotUUID: string;
  snapshotSize: number;
  snapshotUrl: string;
  snapshotWidth: number;
  snapshotHeight: number;
  snapshotType: string;
}

export interface FileElem {
  filePath: string;
  uuid: string;
  sourceUrl: string;
  fileName: string;
  fileSize: number;
  fileType: string;
}

export interface MergeElem {
  title: string;
  abstractList: string[];
  multiMessage: Message[];
  messageEntityList: MessageEntity[];
}

export interface AtTextElem {
  text: string;
  atUserList: string[];
  atUsersInfo: AtInfo[];
  quoteMessage: Message;
  isAtSelf: boolean;
}

export interface FaceElem {
  index: number;
  data: string;
}

export interface LocationElem {
  description: string;
  longitude: number;
  latitude: number;
}

export interface CustomElem {
  data: string;
  description: string;
  extension: string;
}

export interface QuoteElem {
  text: string;
  quoteMessage: Message;
  messageEntityList: MessageEntity[];
}

export interface NotificationElem {
  detail: string;
}

export interface AdvancedTextElem {
  text: string;
  messageEntityList: MessageEntity[];
}

export interface TypingElem {
  msgTips: string;
}

export interface Message {
  clientMsgID: string;
  serverMsgID: string;
  createTime: number;
  sendTime: number;
  sessionType: number;
  sendID: string;
  recvID: string;
  msgFrom: number;
  contentType: number;
  senderPlatformID: number;
  senderNickname: string;
  senderFaceURL: string;
  groupID: string;
  content: string;
  seq: number;
  isRead: boolean;
  status: number;
  isReact: boolean;
  isExternalExtensions: boolean;
  offlinePush: OfflinePushInfo;
  attachedInfo: string;
  ex: string;
  localEx: string;
  textElem: TextElem;
  cardElem: CardElem;
  pictureElem: PictureElem;
  soundElem: SoundElem;
  videoElem: VideoElem;
  fileElem: FileElem;
  mergeElem: MergeElem;
  atTextElem: AtTextElem;
  faceElem: FaceElem;
  locationElem: LocationElem;
  customElem: CustomElem;
  quoteElem: QuoteElem;
  notificationElem: NotificationElem;
  advancedTextElem: AdvancedTextElem;
  typingElem: TypingElem;
  attachedInfoElem: AttachedInfoElem;
}

export interface AtInfo {
  atUserID: string;
  groupNickname: string;
}

export interface AttachedInfoElem {
  groupHasReadInfo: GroupHasReadInfo;
  isPrivateChat: boolean;
  burnDuration: number;
  hasReadTime: number;
  messageEntityList: MessageEntity[];
  isEncryption: boolean;
  inEncryptStatus: boolean;
  messageReactionElem: ReactionElem[];
  uploadProgress: UploadProgress;
}

export interface UploadProgress {
  total: number;
  save: number;
  current: number;
  uploadID: string;
}

export interface ReactionElem {
  counter: number;
  type: number;
  userReactionList: UserReactionElem[];
  canRepeat: boolean;
  info: string;
}

export interface UserReactionElem {
  userID: string;
  counter: number;
  info: string;
}

export interface MessageEntity {
  type: string;
  offset: number;
  length: number;
  url: string;
  ex: string;
}

export interface SearchMessageResult {
  totalCount: number;
  searchResultItems: SearchResultItem[];
}

export interface SearchResultItem {
  conversationID: string;
  conversationType: number;
  showName: string;
  faceURL: string;
  messageCount: number;
  messageList: Message[];
}

export interface GetAdvancedHistoryMessageListParams {
  lastMinSeq: number;
  conversationID: string;
  startClientMsgID: string;
  count: number;
}

export interface SearchMessagesParams {
  conversationID: string;
  keywordList: string[];
  keywordListMatchType: number;
  senderUserIDList: string[];
  messageTypeList: number[];
  searchTimePosition: number;
  searchTimePeriod: number;
  pageIndex: number;
  count: number;
}

export interface AdvancedMessageResult {
  messageList: Message[];
  lastMinSeq: number;
  isEnd: boolean;
  errCode: number;
  errMsg: string;
}

export interface FindMessageResult {
  totalCount: number;
  findResultItems: SearchResultItem[];
}

export interface OfflinePushInfo {
  title: string;
  desc: string;
  ex: string;
  iOSPushSound: string;
  iOSBadgeCount: boolean;
  signalInfo: string;
}

