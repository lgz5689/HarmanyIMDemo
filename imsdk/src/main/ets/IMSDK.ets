import {
  AcceptFriendApplicationArgs,
  AcceptGroupApplicationArgs,
  AddBlackArgs,
  AddFriendArgs,
  BaseArgs,
  ChangeGroupMemberMuteArgs,
  ChangeGroupMuteArgs,
  CheckFriendArgs,
  ClearConversationAndDeleteAllMsgArgs,
  CreateAdvancedQuoteMessageArgs,
  CreateAdvancedTextMessageArgs,
  CreateCardMessageArgs,
  CreateCustomMessageArgs,
  CreateFaceMessageArgs,
  CreateFileMessageArgs,
  CreateFileMessageByURLArgs,
  CreateFileMessageFromFullPathArgs,
  CreateForwardMessageArgs,
  CreateGroupArgs,
  CreateImageMessageArgs,
  CreateImageMessageByURLArgs,
  CreateImageMessageFromFullPathArgs,
  CreateLocationMessageArgs,
  CreateMergerMessageArgs,
  CreateQuoteMessageArgs,
  CreateSoundMessageArgs,
  CreateSoundMessageByURLArgs,
  CreateSoundMessageFromFullPathArgs,
  CreateTextAtMessageArgs,
  CreateTextMessageArgs,
  CreateVideoMessageArgs,
  CreateVideoMessageByURLArgs,
  CreateVideoMessageFromFullPathArgs,
  DeleteAllMsgFromLocalAndSVRArgs,
  DeleteAllMsgFromLocalArgs,
  DeleteConversationAndDeleteAllMsgArgs,
  DeleteFriendArgs,
  DeleteMessageArgs,
  DeleteMessageFromLocalStorageArgs,
  DismissGroupArgs,
  FindMessageListArgs,
  GetAdvancedHistoryMessageListArgs,
  GetAdvancedHistoryMessageListReverseArgs,
  GetBlackListArgs,
  GetConversationIdBySessionTypeArgs,
  GetConversationListSplitArgs,
  GetFriendApplicationListAsApplicantArgs,
  GetFriendApplicationListAsRecipientArgs,
  GetFriendListArgs,
  GetFriendListPageArgs,
  GetGroupApplicationListAsApplicantArgs,
  GetGroupApplicationListAsRecipientArgs,
  GetGroupMemberListArgs,
  GetGroupMemberListByJoinTimeFilterArgs,
  GetGroupMemberOwnerAndAdminArgs,
  GetJoinedGroupListArgs,
  GetJoinedGroupListPageArgs,
  GetMultipleConversationArgs,
  GetOneConversationArgs,
  GetSpecifiedFriendsInfoArgs,
  GetSpecifiedGroupMembersInfoArgs,
  GetSpecifiedGroupsInfoArgs,
  GetUsersInfoArgs,
  GetUsersInGroupArgs,
  GetUserStatusArgs,
  HideAllConversationsArgs,
  HideConversationArgs,
  InitSDKArgs,
  InsertGroupMessageToLocalStorageArgs,
  InsertSingleMessageToLocalStorageArgs,
  InviteUserToGroupArgs,
  IsJoinGroupArgs,
  JoinGroupArgs,
  KickGroupMemberArgs,
  LoginArgs,
  MarkConversationMessageAsReadArgs,
  QuitGroupArgs,
  RefuseFriendApplicationArgs,
  RefuseGroupApplicationArgs,
  RemoveBlackArgs,
  RevokeMessageArgs,
  SearchFriendsArgs,
  SearchGroupMembersArgs,
  SearchGroupsArgs,
  SearchLocalMessagesArgs,
  SendMessageArgs,
  SendMessageNotOSSArgs,
  SetAppBackgroundStatusArgs,
  SetConversationArgs,
  SetConversationDraftArgs,
  SetGroupInfoArgs,
  SetGroupMemberInfoArgs,
  SetMessageLocalExArgs,
  SetSelfInfoArgs,
  SubscribeUsersStatusArgs,
  TransferGroupOwnerArgs,
  TypingStatusUpdateArgs,
  UnsubscribeUsersStatusArgs,
  UpdateFriendsArgs
} from "./APIArgs";
import {
  AdvancedMessageResult,
  ApplyToAddFriendReq,
  AtInfo,
  BlackInfo,
  BoolValue,
  CardElem,
  Conversation,
  ConversationArgs,
  ConversationReq,
  CreateGroupReq,
  FileElem,
  FindMessageResult,
  FriendApplicationInfo,
  FriendInfo,
  GetAdvancedHistoryMessageListParams,
  GroupApplicationInfo,
  GroupInfo,
  GroupInfoForSet,
  GroupMember,
  IMConfig,
  Message,
  MessageEntity,
  NumberValue,
  OfflinePushInfo,
  OnlineStatus,
  PictureBaseInfo,
  ProcessFriendApplicationParams,
  PublicUserInfo,
  SearchFriendItem,
  SearchFriendsParam,
  SearchGroupMembersParam,
  SearchGroupsParam,
  SearchMessageResult,
  SearchMessagesParams,
  SoundElem,
  StringValue,
  UpdateFriendsReq,
  UserIDResult,
  UserInfo,
  VideoElem,
  GroupMemberInfoArgs
} from "./Data";
import { ConversationType, GroupMemberFilter, JoinSource, LoginStatus } from "./Enum";
import { IConnListener } from "./Listener";
import { BaseCallBack, dispatchMsg, IMsgSendCallBack, registerHandler, registerSendMsgHandler } from "./MessageHandle";
import { APIKey } from "./native/APIKey";
import { CallAPI, Redirect, registerMsgCallBack } from "./native/NativeSDK";
import { ToJson } from "./utils/Json";

let operationId = 0

function GetOperationId(): string {
  operationId = operationId + 1;
  return operationId.toString()
}

export function RedirectStdOut(dir: string) {
  Redirect(dir)
}

export function InitSDK(config: IMConfig, conn: IConnListener): boolean {
  registerMsgCallBack(dispatchMsg)
  let initSDKArgs: InitSDKArgs = {
    operationId: GetOperationId(),
    config: ToJson(config),
  }
  let res = CallAPI<BoolValue>(APIKey.InitSDK, initSDKArgs) as BoolValue
  return res.value;
}

export function UnInitSDK(): void {
  const unInitSDKArgs: BaseArgs = {
    operationId: GetOperationId(),
  };
  CallAPI(APIKey.UnInitSDK, unInitSDKArgs);
}

export function Login(cb: BaseCallBack<boolean>, uid: string, token: string): void {
  const args: LoginArgs = {
    operationId: GetOperationId(),
    uid: uid,
    token: token
  }
  registerHandler<boolean>(args.operationId, cb)
  CallAPI(APIKey.Login, args)
}

export function Logout(cb: (suc: boolean, errCode: number, errMsg: string) => void): void {
  const args: BaseArgs = {
    operationId: GetOperationId(),
  };
  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.Logout, args);
}

export function SetAppBackGroundStatus(cb: (suc: boolean, errCode: number, errMsg: string) => void,
  isBackground: boolean): void {
  const args: SetAppBackgroundStatusArgs = {
    operationId: GetOperationId(),
    isBackground: isBackground,
  };
  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetAppBackgroundStatus, args);
}

export function NetworkStatusChanged(cb: (suc: boolean, errCode: number, errMsg: string) => void): void {
  const args: BaseArgs = {
    operationId: GetOperationId(),
  };
  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.NetworkStatusChanged, args);
}

export function GetLoginStatus(): LoginStatus {
  const args: BaseArgs = {
    operationId: GetOperationId(),
  };
  const res = CallAPI<NumberValue>(APIKey.GetLoginStatus, args) as NumberValue;
  return res.value as LoginStatus;
}

export function GetLoginUserId(): string {
  const args: BaseArgs = {
    operationId: GetOperationId(),
  };
  const res = CallAPI<StringValue>(APIKey.GetLoginUserID, args) as StringValue;
  return res.value;
}

export function CreateTextMessage(text: string): Message {
  const args: CreateTextMessageArgs = {
    operationId: GetOperationId(),
    text,
  };
  return CallAPI<Message>(APIKey.CreateTextMessage, args) as Message;
}

export function CreateAdvancedTextMessage(text: string, messageEntityList: MessageEntity[]): Message {
  const args: CreateAdvancedTextMessageArgs = {
    operationId: GetOperationId(),
    text,
    messageEntityList: ToJson(messageEntityList),
  };
  return CallAPI<Message>(APIKey.CreateAdvancedTextMessage, args) as Message;
}

export function CreateTextAtMessage(text: string, atUserList: string[], atUsersInfo: AtInfo[],
  message: Message): Message {
  const args: CreateTextAtMessageArgs = {
    operationId: GetOperationId(),
    text,
    atUserList: ToJson(atUserList),
    atUsersInfo: ToJson(atUsersInfo),
    message: ToJson(message),
  };
  return CallAPI<Message>(APIKey.CreateTextAtMessage, args) as Message;
}

export function CreateLocationMessage(description: string, longitude: number, latitude: number): Message {
  const args: CreateLocationMessageArgs = {
    operationId: GetOperationId(),
    description,
    longitude,
    latitude,
  };
  return CallAPI<Message>(APIKey.CreateLocationMessage, args) as Message;
}

export function CreateCustomMessage(data: string, extension: string, description: string): Message {
  const args: CreateCustomMessageArgs = {
    operationId: GetOperationId(),
    data,
    extension,
    description,
  };
  return CallAPI<Message>(APIKey.CreateCustomMessage, args) as Message;
}

export function CreateQuoteMessage(text: string, message: Message): Message {
  const args: CreateQuoteMessageArgs = {
    operationId: GetOperationId(),
    text,
    message: ToJson(message),
  };
  return CallAPI<Message>(APIKey.CreateQuoteMessage, args) as Message;
}

export function CreateAdvancedQuoteMessage(text: string, message: Message,
  messageEntityList: MessageEntity[]): Message {
  const args: CreateAdvancedQuoteMessageArgs = {
    operationId: GetOperationId(),
    text,
    message: ToJson(message),
    messageEntityList: ToJson(messageEntityList),
  };
  return CallAPI<Message>(APIKey.CreateAdvancedQuoteMessage, args) as Message;
}

export function CreateCardMessage(cardInfo: CardElem): Message {
  const args: CreateCardMessageArgs = {
    operationId: GetOperationId(),
    cardInfo: ToJson(cardInfo),
  };
  return CallAPI<Message>(APIKey.CreateCardMessage, args) as Message;
}

export function CreateVideoMessageFromFullPath(videoFullPath: string, videoType: string, duration: number,
  snapshotFullPath: string): Message {
  const args: CreateVideoMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    videoFullPath,
    videoType,
    duration,
    snapshotFullPath,
  };
  return CallAPI<Message>(APIKey.CreateVideoMessageFromFullPath, args) as Message;
}

export function CreateImageMessageFromFullPath(imageFullPath: string): Message {
  const args: CreateImageMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    imageFullPath,
  };
  return CallAPI<Message>(APIKey.CreateImageMessageFromFullPath, args) as Message;
}

export function CreateSoundMessageFromFullPath(soundPath: string, duration: number): Message {
  const args: CreateSoundMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    soundPath,
    duration,
  };
  return CallAPI<Message>(APIKey.CreateSoundMessageFromFullPath, args) as Message;
}

export function CreateFileMessageFromFullPath(fileFullPath: string, fileName: string): Message {
  const args: CreateFileMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    fileFullPath,
    fileName,
  };
  return CallAPI<Message>(APIKey.CreateFileMessageFromFullPath, args) as Message;
}

export function CreateImageMessage(imagePath: string): Message {
  const args: CreateImageMessageArgs = {
    operationId: GetOperationId(),
    imagePath,
  };
  return CallAPI<Message>(APIKey.CreateImageMessage, args) as Message;
}

export function CreateImageMessageByURL(sourcePath: string, sourcePicture: PictureBaseInfo, bigPicture: PictureBaseInfo,
  snapshotPicture: PictureBaseInfo): Message {
  const args: CreateImageMessageByURLArgs = {
    operationId: GetOperationId(),
    sourcePath,
    sourcePicture: ToJson(sourcePicture),
    bigPicture: ToJson(bigPicture),
    snapshotPicture: ToJson(snapshotPicture),
  };
  return CallAPI<Message>(APIKey.CreateImageMessageByURL, args) as Message;
}

export function CreateSoundMessageByURL(soundBaseInfo: SoundElem): Message {
  const args: CreateSoundMessageByURLArgs = {
    operationId: GetOperationId(),
    soundBaseInfo: ToJson(soundBaseInfo),
  };
  return CallAPI<Message>(APIKey.CreateSoundMessageByURL, args) as Message;
}

export function CreateSoundMessage(soundPath: string, duration: number): Message {
  const args: CreateSoundMessageArgs = {
    operationId: GetOperationId(),
    soundPath,
    duration
  };
  return CallAPI<Message>(APIKey.CreateSoundMessage, args) as Message;
}

export function CreateVideoMessageByURL(videoBaseInfo: VideoElem): Message {
  const args: CreateVideoMessageByURLArgs = {
    operationId: GetOperationId(),
    videoBaseInfo: ToJson(videoBaseInfo),
  };
  return CallAPI<Message>(APIKey.CreateVideoMessageByURL, args) as Message;
}

export function CreateVideoMessage(videoPath: string, videoType: string, duration: number,
  snapshotPath: string): Message {
  const args: CreateVideoMessageArgs = {
    operationId: GetOperationId(),
    videoPath,
    videoType,
    duration,
    snapshotPath,
  };
  return CallAPI<Message>(APIKey.CreateVideoMessage, args) as Message;
}

export function CreateFileMessageByURL(fileBaseInfo: FileElem): Message {
  const args: CreateFileMessageByURLArgs = {
    operationId: GetOperationId(),
    fileBaseInfo: ToJson(fileBaseInfo),
  };
  return CallAPI<Message>(APIKey.CreateFileMessageByURL, args) as Message;
}

export function CreateFileMessage(filePath: string, fileName: string): Message {
  const args: CreateFileMessageArgs = {
    operationId: GetOperationId(),
    filePath,
    fileName,
  };
  return CallAPI<Message>(APIKey.CreateFileMessage, args) as Message;
}

export function CreateMergerMessage(messageList: Message[], title: string, summaryList: string[]): Message {
  const args: CreateMergerMessageArgs = {
    operationId: GetOperationId(),
    messageList: ToJson(messageList),
    title,
    summaryList: ToJson(summaryList),
  };
  return CallAPI<Message>(APIKey.CreateMergerMessage, args) as Message;
}

export function CreateFaceMessage(index: number, data: string): Message {
  const args: CreateFaceMessageArgs = {
    operationId: GetOperationId(),
    index,
    data,
  };
  return CallAPI<Message>(APIKey.CreateFaceMessage, args) as Message;
}

export function CreateForwardMessage(message: Message): Message {
  const args: CreateForwardMessageArgs = {
    operationId: GetOperationId(),
    message: ToJson(message),
  };
  return CallAPI<Message>(APIKey.CreateForwardMessage, args) as Message;
}

export function GetAllConversationList(cb: (result: Conversation[], errCode: number,
  errMsg: string) => void): void {
  const args: BaseArgs = {
    operationId: GetOperationId()
  };
  registerHandler<Conversation[]>(args.operationId, cb);
  CallAPI(APIKey.GetAllConversationList, args);
}

export function GetConversationListSplit(cb: (result: Conversation[], errCode: number, errMsg: string) => void,
  offset: number, count: number): void {
  const args: GetConversationListSplitArgs = {
    operationId: GetOperationId(),
    offset,
    count
  };
  registerHandler<Conversation[]>(args.operationId, cb);
  CallAPI(APIKey.GetConversationListSplit, args);
}

export function GetOneConversation(
  cb: (result: Conversation, errCode: number, errMsg: string) => void,
  sessionType: ConversationType,
  sourceId: string
): void {
  const args: GetOneConversationArgs = {
    operationId: GetOperationId(),
    sessionType,
    sourceId
  };
  registerHandler<Conversation>(args.operationId, cb);
  CallAPI(APIKey.GetOneConversation, args);
}

export function GetMultipleConversation(
  cb: (result: Conversation[], errCode: number, errMsg: string) => void,
  conversationIdList: string[]
): void {
  const args: GetMultipleConversationArgs = {
    operationId: GetOperationId(),
    conversationIdList: ToJson(conversationIdList)
  };

  registerHandler<Conversation[]>(args.operationId, cb);
  CallAPI(APIKey.GetMultipleConversation, args);
}

export function HideConversation(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string
): void {
  const args: HideConversationArgs = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.HideConversation, args);
}

export function SetConversation(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string,
  req: ConversationReq
): void {
  const args: SetConversationArgs = {
    operationId: GetOperationId(),
    conversationId,
    req: ToJson(req)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetConversation, args);
}

export function SetConversationDraft(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string,
  draftText: string
): void {
  const args: SetConversationDraftArgs = {
    operationId: GetOperationId(),
    conversationId,
    draftText
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetConversationDraft, args);
}

export function GetTotalUnreadMsgCount(
  cb: (result: number, errCode: number, errMsg: string) => void
): void {
  const args: BaseArgs = {
    operationId: GetOperationId()
  };

  registerHandler<number>(args.operationId, cb);
  CallAPI(APIKey.GetTotalUnreadMsgCount, args);
}

export function GetAtAllTag(): string {
  const args: BaseArgs = {
    operationId: GetOperationId()
  };

  const res = CallAPI<StringValue>(APIKey.GetAtAllTag, args) as StringValue;
  return res.value;
}

export function GetConversationIdBySessionType(sourceId: string, sessionType: number): string {
  const args: GetConversationIdBySessionTypeArgs = {
    operationId: GetOperationId(),
    sourceId,
    sessionType
  };

  const res = CallAPI<StringValue>(APIKey.GetConversationIDBySessionType, args) as StringValue;
  return res.value;
}

export function SendMessage(cb: IMsgSendCallBack, message: Message, recvId: string, groupId: string,
  offlinePushInfo: OfflinePushInfo, isOnlineOnly: boolean): void {
  const args: SendMessageArgs = {
    operationId: GetOperationId(),
    message: ToJson(message),
    recvId,
    groupId,
    offlinePushInfo: ToJson(offlinePushInfo),
    isOnlineOnly
  };
  registerSendMsgHandler(args.operationId, cb)
  CallAPI(APIKey.SendMessage, args);
}

export function SendMessageNotOSS(cb: IMsgSendCallBack, message: Message, recvId: string, groupId: string,
  offlinePushInfo: OfflinePushInfo, isOnlineOnly: boolean): void {
  const args: SendMessageNotOSSArgs = {
    operationId: GetOperationId(),
    message: ToJson(message),
    recvId,
    groupId,
    offlinePushInfo: ToJson(offlinePushInfo),
    isOnlineOnly
  };
  registerSendMsgHandler(args.operationId, cb)
  CallAPI(APIKey.SendMessageNotOss, args);
}

export function FindMessageList(
  cb: (result: FindMessageResult, errCode: number, errMsg: string) => void,
  findMessageOptions: ConversationArgs[]
): void {
  const args: FindMessageListArgs = {
    operationId: GetOperationId(),
    findMessageOptions: ToJson(findMessageOptions)
  };

  registerHandler<FindMessageResult>(args.operationId, cb);
  CallAPI(APIKey.FindMessageList, args);
}

export function GetAdvancedHistoryMessageList(
  cb: (result: AdvancedMessageResult, errCode: number, errMsg: string) => void,
  getMessageOptions: GetAdvancedHistoryMessageListParams
): void {
  const args: GetAdvancedHistoryMessageListArgs = {
    operationId: GetOperationId(),
    getMessageOptions: ToJson(getMessageOptions)
  };

  registerHandler<AdvancedMessageResult>(args.operationId, cb);
  CallAPI(APIKey.GetAdvancedHistoryMessageList, args);
}

export function GetAdvancedHistoryMessageListReverse(
  cb: (result: AdvancedMessageResult, errCode: number, errMsg: string) => void,
  getMessageOptions: GetAdvancedHistoryMessageListParams
): void {
  const args: GetAdvancedHistoryMessageListReverseArgs = {
    operationId: GetOperationId(),
    getMessageOptions: ToJson(getMessageOptions)
  };

  registerHandler<AdvancedMessageResult>(args.operationId, cb);
  CallAPI(APIKey.GetAdvancedHistoryMessageListReverse, args);
}

export function RevokeMessage(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string,
  clientMsgId: string
): void {
  const args: RevokeMessageArgs = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RevokeMessage, args);
}

export function TypingStatusUpdate(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  recvId: string,
  msgTip: string
): void {
  const args: TypingStatusUpdateArgs = {
    operationId: GetOperationId(),
    recvId,
    msgTip
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.TypingStatusUpdate, args);
}

export function MarkConversationMessageAsRead(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string
): void {
  const args: MarkConversationMessageAsReadArgs = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.MarkConversationMessageAsRead, args);
}

export function DeleteMessageFromLocalStorage(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string,
  clientMsgId: string
): void {
  const args: DeleteMessageFromLocalStorageArgs = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteMessageFromLocalStorage, args);
}

export function DeleteMessage(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string,
  clientMsgId: string
): void {
  const args: DeleteMessageArgs = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteMessage, args);
}

export function HideAllConversations(
  cb: (result: boolean, errCode: number, errMsg: string) => void
): void {
  const args: HideAllConversationsArgs = {
    operationId: GetOperationId()
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.HideAllConversations, args);
}

export function DeleteAllMsgFromLocalAndSvr(
  cb: (result: boolean, errCode: number, errMsg: string) => void
): void {
  const args: DeleteAllMsgFromLocalAndSVRArgs = {
    operationId: GetOperationId()
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteAllMsgFromLocalAndSvr, args);
}

export function DeleteAllMsgFromLocal(
  cb: (result: boolean, errCode: number, errMsg: string) => void
): void {
  const args: DeleteAllMsgFromLocalArgs = {
    operationId: GetOperationId()
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteAllMsgFromLocal, args);
}

export function ClearConversationAndDeleteAllMsg(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string
): void {
  const args: ClearConversationAndDeleteAllMsgArgs = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.ClearConversationAndDeleteAllMsg, args);
}

export function DeleteConversationAndDeleteAllMsg(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string
): void {
  const args: DeleteConversationAndDeleteAllMsgArgs = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteConversationAndDeleteAllMsg, args);
}

export function InsertSingleMessageToLocalStorage(
  cb: (result: Message, errCode: number, errMsg: string) => void,
  message: Message,
  recvId: string,
  sendId: string
): void {
  const args: InsertSingleMessageToLocalStorageArgs = {
    operationId: GetOperationId(),
    message: JSON.stringify(message),
    recvId,
    sendId
  };

  registerHandler<Message>(args.operationId, cb);
  CallAPI(APIKey.InsertSingleMessageToLocalStorage, args);
}

export function InsertGroupMessageToLocalStorage(
  cb: (result: Message, errCode: number, errMsg: string) => void,
  message: Message,
  groupId: string,
  sendId: string
): void {
  const args: InsertGroupMessageToLocalStorageArgs = {
    operationId: GetOperationId(),
    message: JSON.stringify(message),
    groupId,
    sendId
  };

  registerHandler<Message>(args.operationId, cb);
  CallAPI(APIKey.InsertGroupMessageToLocalStorage, args);
}

export function SearchLocalMessages(
  cb: (result: SearchMessageResult, errCode: number, errMsg: string) => void,
  searchParam: SearchMessagesParams
): void {
  const args: SearchLocalMessagesArgs = {
    operationId: GetOperationId(),
    searchParam: JSON.stringify(searchParam)
  };

  registerHandler<SearchMessageResult>(args.operationId, cb);
  CallAPI(APIKey.SearchLocalMessages, args);
}

export function SetMessageLocalEx(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string,
  clientMsgId: string,
  localEx: string
): void {
  const args: SetMessageLocalExArgs = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId,
    localEx
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetMessageLocalEx, args);
}

export function GetUsersInfo(
  cb: (result: PublicUserInfo[], errCode: number, errMsg: string) => void,
  userIds: string[]
): void {
  const args: GetUsersInfoArgs = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<PublicUserInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetUsersInfo, args);
}

export function SetSelfInfo(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  userInfo: UserInfo
): void {
  const args: SetSelfInfoArgs = {
    operationId: GetOperationId(),
    userInfo: JSON.stringify(userInfo)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetSelfInfo, args);
}

export function GetSelfUserInfo(
  cb: (result: UserInfo, errCode: number, errMsg: string) => void
): void {
  const args: BaseArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<UserInfo>(args.operationId, cb);
  CallAPI(APIKey.GetSelfUserInfo, args);
}

export function SubscribeUsersStatus(
  cb: (result: OnlineStatus[], errCode: number, errMsg: string) => void,
  userIds: string[]
): void {
  const args: SubscribeUsersStatusArgs = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<OnlineStatus[]>(args.operationId, cb);
  CallAPI(APIKey.SubscribeUsersStatus, args);
}

export function UnsubscribeUsersStatus(
  cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIds: string[]
): void {
  const args: UnsubscribeUsersStatusArgs = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.UnsubscribeUsersStatus, args);
}

export function GetSubscribeUsersStatus(
  cb: (result: OnlineStatus[], errCode: number, errMsg: string) => void
): void {
  const args: BaseArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<OnlineStatus[]>(args.operationId, cb);
  CallAPI(APIKey.GetSubscribeUsersStatus, args);
}

export function GetUserStatus(cb: (result: OnlineStatus[], errCode: number, errMsg: string) => void,
  userIds: string[]): void {
  const args: GetUserStatusArgs = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<OnlineStatus[]>(args.operationId, cb);
  CallAPI(APIKey.GetUserStatus, args);
}

export function GetSpecifiedFriendsInfo(cb: (result: FriendInfo[], errCode: number, errMsg: string) => void,
  userIdList: string[], filterBlack: boolean): void {
  const args: GetSpecifiedFriendsInfoArgs = {
    operationId: GetOperationId(),
    userIdList: JSON.stringify(userIdList),
    filterBlack
  };

  registerHandler<FriendInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetSpecifiedFriendsInfo, args);
}

export function GetFriendList(cb: (result: FriendInfo[], errCode: number, errMsg: string) => void,
  filterBlack: boolean): void {
  const args: GetFriendListArgs = {
    operationId: GetOperationId(),
    filterBlack
  };

  registerHandler<FriendInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetFriendList, args);
}

export function GetFriendListPage(cb: (result: FriendInfo[], errCode: number, errMsg: string) => void,
  offset: number, count: number, filterBlack: boolean): void {
  const args: GetFriendListPageArgs = {
    operationId: GetOperationId(),
    offset,
    count,
    filterBlack
  };

  registerHandler<FriendInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetFriendListPage, args);
}

export function SearchFriends(cb: (result: SearchFriendItem[], errCode: number, errMsg: string) => void,
  searchParam: SearchFriendsParam): void {
  const args: SearchFriendsArgs = {
    operationId: GetOperationId(),
    searchParam: JSON.stringify(searchParam)
  };

  registerHandler<SearchFriendItem[]>(args.operationId, cb);
  CallAPI(APIKey.SearchFriends, args);
}

export function UpdateFriends(cb: (result: boolean, errCode: number, errMsg: string) => void,
  req: UpdateFriendsReq): void {
  const args: UpdateFriendsArgs = {
    operationId: GetOperationId(),
    req: JSON.stringify(req)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.UpdateFriends, args);
}

export function CheckFriend(cb: (result: UserIDResult[], errCode: number, errMsg: string) => void,
  userIdList: string[]): void {
  const args: CheckFriendArgs = {
    operationId: GetOperationId(),
    userIdList: JSON.stringify(userIdList)
  };

  registerHandler<UserIDResult[]>(args.operationId, cb);
  CallAPI(APIKey.CheckFriend, args);
}

export function AddFriend(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIdReqMsg: ApplyToAddFriendReq): void {
  const args: AddFriendArgs = {
    operationId: GetOperationId(),
    userIdReqMsg: JSON.stringify(userIdReqMsg)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AddFriend, args);
}

export function DeleteFriend(cb: (result: boolean, errCode: number, errMsg: string) => void,
  friendUserId: string): void {
  const args: DeleteFriendArgs = {
    operationId: GetOperationId(),
    friendUserId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteFriend, args);
}

export function GetFriendApplicationListAsRecipient(cb: (result: FriendApplicationInfo[], errCode: number,
  errMsg: string) => void): void {
  const args: GetFriendApplicationListAsRecipientArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<FriendApplicationInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetFriendApplicationListAsRecipient, args);
}

export function GetFriendApplicationListAsApplicant(cb: (result: FriendApplicationInfo[], errCode: number,
  errMsg: string) => void): void {
  const args: GetFriendApplicationListAsApplicantArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<FriendApplicationInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetFriendApplicationListAsApplicant, args);
}

export function AcceptFriendApplication(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIdHandleMsg: ProcessFriendApplicationParams): void {
  const args: AcceptFriendApplicationArgs = {
    operationId: GetOperationId(),
    userIdHandleMsg: JSON.stringify(userIdHandleMsg)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AcceptFriendApplication, args);
}

export function RefuseFriendApplication(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIdHandleMsg: ProcessFriendApplicationParams): void {
  const args: RefuseFriendApplicationArgs = {
    operationId: GetOperationId(),
    userIdHandleMsg: JSON.stringify(userIdHandleMsg)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RefuseFriendApplication, args);
}

export function AddBlack(cb: (result: boolean, errCode: number, errMsg: string) => void, blackUserId: string,
  ex: string): void {
  const args: AddBlackArgs = {
    operationId: GetOperationId(),
    blackUserId,
    ex
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AddBlack, args);
}

export function GetBlackList(cb: (result: BlackInfo[], errCode: number, errMsg: string) => void): void {
  const args: GetBlackListArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<BlackInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetBlackList, args);
}

export function RemoveBlack(cb: (result: boolean, errCode: number, errMsg: string) => void,
  removeUserId: string): void {
  const args: RemoveBlackArgs = {
    operationId: GetOperationId(),
    removeUserId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RemoveBlack, args);
}

export function CreateGroup(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupReqInfo: CreateGroupReq): void {
  const args: CreateGroupArgs = {
    operationId: GetOperationId(),
    groupReqInfo: ToJson(groupReqInfo),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.CreateGroup, args);
}

export function JoinGroup(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupId: string, reqMsg: string, joinSource: JoinSource, ex: string): void {
  const args: JoinGroupArgs = {
    operationId: GetOperationId(),
    groupId,
    reqMsg,
    joinSource: joinSource as number,
    ex,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.JoinGroup, args);
}

export function QuitGroup(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupId: string): void {
  const args: QuitGroupArgs = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.QuitGroup, args);
}

export function DismissGroup(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupId: string): void {
  const args: DismissGroupArgs = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DismissGroup, args);
}

export function ChangeGroupMute(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupId: string, isMute: boolean): void {
  const args: ChangeGroupMuteArgs = {
    operationId: GetOperationId(),
    groupId,
    isMute,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.ChangeGroupMute, args);
}

export function ChangeGroupMemberMute(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupId: string, userId: string, mutedSeconds: number): void {
  const args: ChangeGroupMemberMuteArgs = {
    operationId: GetOperationId(),
    groupId,
    userId,
    mutedSeconds,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.ChangeGroupMemberMute, args);
}

export function SetGroupMemberInfo(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupMemberInfo: GroupMemberInfoArgs): void {
  const args: SetGroupMemberInfoArgs = {
    operationId: GetOperationId(),
    groupMemberInfo: ToJson(groupMemberInfo),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetGroupMemberInfo, args);
}

export function GetJoinedGroupList(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void): void {
  const args: GetJoinedGroupListArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetJoinedGroupList, args);
}

export function GetJoinedGroupListPage(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void,
  offset: number, count: number): void {
  const args: GetJoinedGroupListPageArgs = {
    operationId: GetOperationId(),
    offset,
    count,
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetJoinedGroupListPage, args);
}

export function GetSpecifiedGroupsInfo(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void,
  groupIdList: string[]): void {
  const args: GetSpecifiedGroupsInfoArgs = {
    operationId: GetOperationId(),
    groupIdList: ToJson(groupIdList),
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetSpecifiedGroupsInfo, args);
}

export function SearchGroups(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void,
  searchParam: SearchGroupsParam): void {
  const args: SearchGroupsArgs = {
    operationId: GetOperationId(),
    searchParam: ToJson(searchParam),
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.SearchGroups, args);
}

export function SetGroupInfo(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupInfo: GroupInfoForSet): void {
  const args: SetGroupInfoArgs = {
    operationId: GetOperationId(),
    groupInfo: ToJson(groupInfo),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetGroupInfo, args);
}

export function GetGroupMemberList(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string, filter: GroupMemberFilter, offset: number, count: number): void {
  const args: GetGroupMemberListArgs = {
    operationId: GetOperationId(),
    groupId,
    filter,
    offset,
    count,
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupMemberList, args);
}

export function GetGroupMemberOwnerAndAdmin(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string): void {
  const args: GetGroupMemberOwnerAndAdminArgs = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupMemberOwnerAndAdmin, args);
}

export function GetGroupMemberListByJoinTimeFilter(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string, offset: number, count: number, joinTimeBegin: number, joinTimeEnd: number,
  filterUserIDList: string[]): void {
  const args: GetGroupMemberListByJoinTimeFilterArgs = {
    operationId: GetOperationId(),
    groupId,
    offset,
    count,
    joinTimeBegin,
    joinTimeEnd,
    filterUserIdList: ToJson(filterUserIDList),
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupMemberListByJoinTimeFilter, args);
}

export function GetSpecifiedGroupMembersInfo(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string, userIdList: string[]): void {
  const args: GetSpecifiedGroupMembersInfoArgs = {
    operationId: GetOperationId(),
    groupId,
    userIdList: ToJson(userIdList),
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetSpecifiedGroupMembersInfo, args);
}

export function KickGroupMember(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  reason: string, userIdList: string[]): void {
  const args: KickGroupMemberArgs = {
    operationId: GetOperationId(),
    groupId,
    reason,
    userIdList: ToJson(userIdList),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.KickGroupMember, args);
}

export function TransferGroupOwner(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  newOwnerUserId: string): void {
  const args: TransferGroupOwnerArgs = {
    operationId: GetOperationId(),
    groupId,
    newOwnerUserId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.TransferGroupOwner, args);
}

export function InviteUserToGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  reason: string, userIdList: string[]): void {
  const args: InviteUserToGroupArgs = {
    operationId: GetOperationId(),
    groupId,
    reason,
    userIdList: ToJson(userIdList),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.InviteUserToGroup, args);
}

export function GetGroupApplicationListAsRecipient(cb: (result: GroupApplicationInfo[], errCode: number,
  errMsg: string) => void): void {
  const args: GetGroupApplicationListAsRecipientArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<GroupApplicationInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupApplicationListAsRecipient, args);
}

export function GetGroupApplicationListAsApplicant(cb: (result: GroupApplicationInfo[], errCode: number,
  errMsg: string) => void): void {
  const args: GetGroupApplicationListAsApplicantArgs = {
    operationId: GetOperationId(),
  };

  registerHandler<GroupApplicationInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupApplicationListAsApplicant, args);
}

export function AcceptGroupApplication(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  fromUserId: string, handleMsg: string): void {
  const args: AcceptGroupApplicationArgs = {
    operationId: GetOperationId(),
    groupId,
    fromUserId,
    handleMsg,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AcceptGroupApplication, args);
}

export function RefuseGroupApplication(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  fromUserId: string, handleMsg: string): void {
  const args: RefuseGroupApplicationArgs = {
    operationId: GetOperationId(),
    groupId,
    fromUserId,
    handleMsg,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RefuseGroupApplication, args);
}

export function SearchGroupMembers(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  searchParam: SearchGroupMembersParam): void {
  const args: SearchGroupMembersArgs = {
    operationId: GetOperationId(),
    searchParam: ToJson(searchParam),
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.SearchGroupMembers, args);
}

export function IsJoinGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string): void {
  const args: IsJoinGroupArgs = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.IsJoinGroup, args);
}

export function GetUsersInGroup(cb: (result: string[], errCode: number, errMsg: string) => void, groupId: string,
  userIdList: string[]): void {
  const args: GetUsersInGroupArgs = {
    operationId: GetOperationId(),
    groupId,
    userIdList,
  };

  registerHandler<string[]>(args.operationId, cb);
  CallAPI(APIKey.GetUsersInGroup, args);
}







