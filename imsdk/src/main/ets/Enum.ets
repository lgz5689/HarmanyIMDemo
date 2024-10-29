export enum PlatformID {
  None = 0,
  IOSPlatformID = 1,
  AndroidPlatformID = 2,
  WindowsPlatformID = 3,
  OSXPlatformID = 4,
  WebPlatformID = 5,
  MiniWebPlatformID = 6,
  LinuxPlatformID = 7,
  AndroidPadPlatformID = 8,
  IPadPlatformID = 9,
  AdminPlatformID = 10,
}

export enum ErrorCode {
  None = 0,
  NetworkError = 10000,
  NetworkTimeoutError = 10001,
  ArgsError = 10002,
  CtxDeadlineExceededError = 10003,
  ResourceLoadNotCompleteError = 10004,
  UnknownCode = 10005,
  SdkInternalError = 10006,
  NoUpdateError = 10007,
  UserIDNotFoundError = 10100,
  LoginOutError = 10101,
  LoginRepeatError = 10102,
  FileNotFoundError = 10200,
  MsgDeCompressionError = 10201,
  MsgDecodeBinaryWsError = 10202,
  MsgBinaryTypeNotSupportError = 10203,
  MsgRepeatError = 10204,
  MsgContentTypeNotSupportError = 10205,
  MsgHasNoSeqError = 10206,
  NotSupportOptError = 10301,
  NotSupportTypeError = 10302,
  UnreadCountError = 10303,
  GroupIDNotFoundError = 10400,
  GroupTypeErr = 10401,
}

export enum LoginStatus {
  Empty = 0,
  Logout = 1,
  Logging = 2,
  Logged = 3,
}

export enum MsgStatus {
  Default,
  Sending,
  SendSuccess,
  SendFailed,
  Deleted,
  Filtered,
}

export enum ContentType {
  Text = 101,
  Picture = 102,
  Sound = 103,
  Video = 104,
  File = 105,
  AtText = 106,
  Merger = 107,
  Card = 108,
  Location = 109,
  Custom = 110,
  Typing = 113,
  Quote = 114,
  Face = 115,
  AdvancedText = 117,
  CustomMsgNotTriggerConversation = 119,
  CustomMsgOnlineOnly = 120,
  ReactionMessageModifier = 121,
  ReactionMessageDeleter = 122,
}

export enum AllowType {
  Allowed,
  NotAllowed,
}

export enum ConversationType {
  Single = 1,
  Group = 3,
  Notification = 4,
}

export enum GroupAtType {
  AtNormal = 0,
  AtMe = 1,
  AtAll = 2,
  AtAllAtMe = 3,
  AtGroupNotice = 4,
}

export enum GroupMemberFilter {
  All,
  Owner,
  Admin,
  Normal,
  AdminAndNormal,
  AdminAndOwner,
}

export enum GroupStatus {
  Normal,
  Banned,
  Dismissed,
  Muted,
}

export enum GroupType {
  Group = 2,
}

export enum GroupVerification {
  ApplyNeedInviteNot,
  AllNeed,
  AllNot,
}

export enum HandleResult {
  Reject = -1,
  Unprocessed = 0,
  Agree = 1,
}

export enum JoinSource {
  Invitation = 2,
  Search = 3,
  QrCode = 4,
}

export enum MessageContentType {
  TextMessage = 101,
  PictureMessage = 102,
  VoiceMessage = 103,
  VideoMessage = 104,
  FileMessage = 105,
  AtTextMessage = 106,
  MergeMessage = 107,
  CardMessage = 108,
  LocationMessage = 109,
  CustomMessage = 110,
  TypingMessage = 113,
  QuoteMessage = 114,
  FaceMessage = 115,
  FriendAdded = 1201,
  OANotification = 1400,
  GroupCreated = 1501,
  MemberQuit = 1504,
  GroupOwnerTransferred = 1507,
  MemberKicked = 1508,
  MemberInvited = 1509,
  MemberEnter = 1510,
  GroupDismissed = 1511,
  GroupMemberMuted = 1512,
  GroupMemberCancelMuted = 1513,
  GroupMuted = 1514,
  GroupCancelMuted = 1515,
  GroupAnnouncementUpdated = 1519,
  GroupNameUpdated = 1518,
  BurnMessageChange = 1701,
  RevokeMessage = 2101,
}

export enum MessageStatus {
  Sending = 1,
  Succeed = 2,
  Failed = 3,
}

export enum RecvMsgOpt {
  Normal = 0,
  NotReceive = 1,
  NotNotify = 2,
}

export enum RoleLevel {
  Owner = 100,
  Admin = 60,
  Normal = 20,
}

export enum LogLevel {
  Panic = 0,
  Fatal = 1,
  Error = 2,
  Warn = 3,
  Info = 4,
  Debug = 5,
}