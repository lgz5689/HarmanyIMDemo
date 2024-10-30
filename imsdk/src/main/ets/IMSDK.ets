import { BaseArgs, InitSDKArgs, LoginArgs } from "./APIArgs";
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
  VideoElem
} from "./Data";
import { ConversationType, GroupMemberFilter, JoinSource, LoginStatus } from "./Enum";
import { IConnListener } from "./Listener";
import { dispatchMsg, registerHandler } from "./MessageHandle";
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

export function Login(cb: (suc: boolean, errCode: number, errMsg: string) => void, uid: string, token: string): void {
  const args: LoginArgs = {
    operationId: GetOperationId(),
    uid: uid,
    token: token
  }
  registerHandler<boolean>(args.operationId, cb)
  CallAPI(APIKey.Login, args)
}

export function Logout(cb: (suc: boolean, errCode: number, errMsg: string) => void): void {
  const args: LogoutArgs = {
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
  const args: NetworkStatusChangedArgs = {
    operationId: GetOperationId(),
  };
  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.NetworkStatusChanged, args);
}

export function GetLoginStatus(): LoginStatus {
  const args: GetLoginStatusArgs = {
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
  return CallAPI<Message>(APIKey.CreateTextMessage, args);
}

export function CreateAdvancedTextMessage(text: string, messageEntityList: MessageEntity[]): Message {
  const args: CreateAdvancedTextMessageArgs = {
    operationId: GetOperationId(),
    text,
    messageEntityList: ToJson(messageEntityList),
  };
  return CallAPI<Message>(APIKey.CreateAdvancedTextMessage, args);
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
  return CallAPI<Message>(APIKey.CreateTextAtMessage, args);
}

export function CreateLocationMessage(description: string, longitude: number, latitude: number): Message {
  const args: CreateLocationMessageArgs = {
    operationId: GetOperationId(),
    description,
    longitude,
    latitude,
  };
  return CallAPI<Message>(APIKey.CreateLocationMessage, args);
}

export function CreateCustomMessage(data: string, extension: string, description: string): Message {
  const args: CreateCustomMessageArgs = {
    operationId: GetOperationId(),
    data,
    extension,
    description,
  };
  return CallAPI<Message>(APIKey.CreateCustomMessage, args);
}

export function CreateQuoteMessage(text: string, message: Message): Message {
  const args: CreateQuoteMessageArgs = {
    operationId: GetOperationId(),
    text,
    message: ToJson(message),
  };
  return CallAPI<Message>(APIKey.CreateQuoteMessage, args);
}

export function CreateAdvancedQuoteMessage(text: string, message: Message,
  messageEntityList: MessageEntity[]): Message {
  const args: CreateAdvancedQuoteMessageArgs = {
    operationId: GetOperationId(),
    text,
    message: ToJson(message),
    messageEntityList: ToJson(messageEntityList),
  };
  return CallAPI<Message>(APIKey.CreateAdvancedQuoteMessage, args);
}

export function CreateCardMessage(cardInfo: CardElem): Message {
  const args: CreateCardMessageArgs = {
    operationId: GetOperationId(),
    cardInfo: ToJson(cardInfo),
  };
  return CallAPI<Message>(APIKey.CreateCardMessage, args);
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
  return CallAPI<Message>(APIKey.CreateVideoMessageFromFullPath, args);
}

export function CreateImageMessageFromFullPath(imageFullPath: string): Message {
  const args: CreateImageMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    imageFullPath,
  };
  return CallAPI<Message>(APIKey.CreateImageMessageFromFullPath, args);
}

export function CreateSoundMessageFromFullPath(soundPath: string, duration: number): Message {
  const args: CreateSoundMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    soundPath,
    duration,
  };
  return CallAPI<Message>(APIKey.CreateSoundMessageFromFullPath, args);
}

export function CreateFileMessageFromFullPath(fileFullPath: string, fileName: string): Message {
  const args: CreateFileMessageFromFullPathArgs = {
    operationId: GetOperationId(),
    fileFullPath,
    fileName,
  };
  return CallAPI<Message>(APIKey.CreateFileMessageFromFullPath, args);
}

export function CreateImageMessage(imagePath: string): Message {
  const args: CreateImageMessageArgs = {
    operationId: GetOperationId(),
    imagePath,
  };
  return CallAPI<Message>(APIKey.CreateImageMessage, args);
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
  return CallAPI<Message>(APIKey.CreateImageMessageByURL, args);
}

export function CreateSoundMessageByURL(soundBaseInfo: SoundElem): Message {
  const args: CreateSoundMessageByURLArgs = {
    operationId: GetOperationId(),
    soundBaseInfo: ToJson(soundBaseInfo),
  };
  return CallAPI<Message>(APIKey.CreateSoundMessageByURL, args);
}

export function CreateVideoMessageByURL(videoBaseInfo: VideoElem): Message {
  const args: CreateVideoMessageByURLArgs = {
    operationId: GetOperationId(),
    videoBaseInfo: ToJson(videoBaseInfo),
  };
  return CallAPI<Message>(APIKey.CreateVideoMessageByURL, args);
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
  return CallAPI<Message>(APIKey.CreateVideoMessage, args);
}

export function CreateFileMessageByURL(fileBaseInfo: FileElem): Message {
  const args: CreateFileMessageByURLArgs = {
    operationId: GetOperationId(),
    fileBaseInfo: ToJson(fileBaseInfo),
  };
  return CallAPI<Message>(APIKey.CreateFileMessageByURL, args);
}

export function CreateFileMessage(filePath: string, fileName: string): Message {
  const args: CreateFileMessageArgs = {
    operationId: GetOperationId(),
    filePath,
    fileName,
  };
  return CallAPI<Message>(APIKey.CreateFileMessage, args);
}

export function CreateMergerMessage(messageList: Message[], title: string, summaryList: string[]): Message {
  const args: CreateMergerMessageArgs = {
    operationId: GetOperationId(),
    messageList: ToJson(messageList),
    title,
    summaryList: ToJson(summaryList),
  };
  return CallAPI<Message>(APIKey.CreateMergerMessage, args);
}

export function CreateFaceMessage(index: number, data: string): Message {
  const args: CreateFaceMessageArgs = {
    operationId: GetOperationId(),
    index,
    data,
  };
  return CallAPI<Message>(APIKey.CreateFaceMessage, args);
}

export function CreateForwardMessage(message: Message): Message {
  const args: CreateForwardMessageArgs = {
    operationId: GetOperationId(),
    message: ToJson(message),
  };
  return CallAPI<Message>(APIKey.CreateForwardMessage, args);
}

export function GetAllConversationList(cb: (result: List<Conversation>, errCode: number,
  errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId()
  };

  registerHandler<List<Conversation>>(args.operationId, cb);
  CallAPI(APIKey.GetAllConversationList, args);
}

export function GetConversationListSplit(cb: (result: List<Conversation>, errCode: number, errMsg: string) => void,
  offset: number, count: number): void {
  const args = {
    operationId: GetOperationId(),
    offset,
    count
  };

  registerHandler<List<Conversation>>(args.operationId, cb);
  CallAPI(APIKey.GetConversationListSplit, args);
}

export function GetOneConversation(cb: (result: Conversation, errCode: number, errMsg: string) => void,
  sessionType: ConversationType, sourceId: string): void {
  const args = {
    operationId: GetOperationId(),
    sessionType,
    sourceId
  };

  registerHandler<Conversation>(args.operationId, cb);
  CallAPI(APIKey.GetOneConversation, args);
}

export function GetMultipleConversation(cb: (result: List<Conversation>, errCode: number, errMsg: string) => void,
  conversationIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    conversationIdList: Utils.ToJson(conversationIdList)
  };

  registerHandler<List<Conversation>>(args.operationId, cb);
  CallAPI(APIKey.GetMultipleConversation, args);
}

export function HideConversation(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.HideConversation, args);
}

export function SetConversation(cb: (result: boolean, errCode: number, errMsg: string) => void, conversationId: string,
  req: ConversationReq): void {
  const args = {
    operationId: GetOperationId(),
    conversationId,
    req: Utils.ToJson(req)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetConversation, args);
}

export function SetConversationDraft(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string, draftText: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId,
    draftText
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetConversationDraft, args);
}

export function GetTotalUnreadMsgCount(cb: (result: number, errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId()
  };

  registerHandler<number>(args.operationId, cb);
  CallAPI(APIKey.GetTotalUnreadMsgCount, args);
}

export function GetAtAllTag(): string {
  const args = {
    operationId: GetOperationId()
  };

  const res = CallAPI<StringValue>(APIKey.GetAtAllTag, args);
  return res.value;
}

export function GetConversationIdBySessionType(sourceId: string, sessionType: number): string {
  const args = {
    operationId: GetOperationId(),
    sourceId,
    sessionType
  };

  const res = CallAPI<StringValue>(APIKey.GetConversationIDBySessionType, args);
  return res.value;
}

export function SendMessage(cb: IMsgSendCallBack, message: Message, recvId: string, groupId: string,
  offlinePushInfo: OfflinePushInfo, isOnlineOnly: boolean): void {
  const args = {
    operationId: GetOperationId(),
    message: Utils.ToJson(message),
    recvId,
    groupId,
    offlinePushInfo: Utils.ToJson(offlinePushInfo),
    isOnlineOnly
  };

  msgSendCallBackDic[args.operationId] = cb;
  CallAPI(APIKey.SendMessage, args);
}

export function SendMessageNotOSS(cb: IMsgSendCallBack, message: Message, recvId: string, groupId: string,
  offlinePushInfo: OfflinePushInfo, isOnlineOnly: boolean): void {
  const args = {
    operationId: GetOperationId(),
    message: Utils.ToJson(message),
    recvId,
    groupId,
    offlinePushInfo: Utils.ToJson(offlinePushInfo),
    isOnlineOnly
  };

  msgSendCallBackDic[args.operationId] = cb;
  CallAPI(APIKey.SendMessageNotOss, args);
}

export function FindMessageList(cb: (result: FindMessageResult, errCode: number, errMsg: string) => void,
  findMessageOptions: ConversationArgs[]): void {
  const args = {
    operationId: GetOperationId(),
    findMessageOptions: Utils.ToJson(findMessageOptions)
  };

  registerHandler<FindMessageResult>(args.operationId, cb);
  CallAPI(APIKey.FindMessageList, args);
}

export function GetAdvancedHistoryMessageList(cb: (result: AdvancedMessageResult, errCode: number,
  errMsg: string) => void, getMessageOptions: GetAdvancedHistoryMessageListParams): void {
  const args = {
    operationId: GetOperationId(),
    getMessageOptions: Utils.ToJson(getMessageOptions)
  };

  registerHandler<AdvancedMessageResult>(args.operationId, cb);
  CallAPI(APIKey.GetAdvancedHistoryMessageList, args);
}

export function GetAdvancedHistoryMessageListReverse(cb: (result: AdvancedMessageResult, errCode: number,
  errMsg: string) => void, getMessageOptions: GetAdvancedHistoryMessageListParams): void {
  const args = {
    operationId: GetOperationId(),
    getMessageOptions: Utils.ToJson(getMessageOptions)
  };

  registerHandler<AdvancedMessageResult>(args.operationId, cb);
  CallAPI(APIKey.GetAdvancedHistoryMessageListReverse, args);
}

export function RevokeMessage(cb: (result: boolean, errCode: number, errMsg: string) => void, conversationId: string,
  clientMsgId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RevokeMessage, args);
}

export function TypingStatusUpdate(cb: (result: boolean, errCode: number, errMsg: string) => void, recvId: string,
  msgTip: string): void {
  const args = {
    operationId: GetOperationId(),
    recvId,
    msgTip
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.TypingStatusUpdate, args);
}

export function MarkConversationMessageAsRead(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.MarkConversationMessageAsRead, args);
}

export function DeleteMessageFromLocalStorage(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string, clientMsgId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteMessageFromLocalStorage, args);
}

export function DeleteMessage(cb: (result: boolean, errCode: number, errMsg: string) => void, conversationId: string,
  clientMsgId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteMessage, args);
}

export function HideAllConversations(cb: (result: boolean, errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId()
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.HideAllConversations, args);
}

export function DeleteAllMsgFromLocalAndSVR(cb: (result: boolean, errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId()
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteAllMsgFromLocalAndSvr, args);
}

export function DeleteAllMsgFromLocal(cb: (result: boolean, errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId()
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteAllMsgFromLocal, args);
}

export function ClearConversationAndDeleteAllMsg(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.ClearConversationAndDeleteAllMsg, args);
}

export function DeleteConversationAndDeleteAllMsg(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteConversationAndDeleteAllMsg, args);
}

export function InsertSingleMessageToLocalStorage(cb: (result: Message, errCode: number, errMsg: string) => void,
  message: Message, recvId: string, sendId: string): void {
  const args = {
    operationId: GetOperationId(),
    message: JSON.stringify(message),
    recvId,
    sendId
  };

  registerHandler<Message>(args.operationId, cb);
  CallAPI(APIKey.InsertSingleMessageToLocalStorage, args);
}

export function InsertGroupMessageToLocalStorage(cb: (result: Message, errCode: number, errMsg: string) => void,
  message: Message, groupId: string, sendId: string): void {
  const args = {
    operationId: GetOperationId(),
    message: JSON.stringify(message),
    groupId,
    sendId
  };

  registerHandler<Message>(args.operationId, cb);
  CallAPI(APIKey.InsertGroupMessageToLocalStorage, args);
}

export function SearchLocalMessages(cb: (result: SearchMessageResult, errCode: number, errMsg: string) => void,
  searchParam: SearchMessagesParams): void {
  const args = {
    operationId: GetOperationId(),
    searchParam: JSON.stringify(searchParam)
  };

  registerHandler<SearchMessageResult>(args.operationId, cb);
  CallAPI(APIKey.SearchLocalMessages, args);
}

export function SetMessageLocalEx(cb: (result: boolean, errCode: number, errMsg: string) => void,
  conversationId: string, clientMsgId: string, localEx: string): void {
  const args = {
    operationId: GetOperationId(),
    conversationId,
    clientMsgId,
    localEx
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetMessageLocalEx, args);
}

export function GetUsersInfo(cb: (result: List<PublicUserInfo>, errCode: number, errMsg: string) => void,
  userIds: string[]): void {
  const args = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<List<PublicUserInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetUsersInfo, args);
}

export function SetSelfInfo(cb: (result: boolean, errCode: number, errMsg: string) => void, userInfo: UserInfo): void {
  const args = {
    operationId: GetOperationId(),
    userInfo: JSON.stringify(userInfo)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetSelfInfo, args);
}

export function GetSelfUserInfo(cb: (result: UserInfo, errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<UserInfo>(args.operationId, cb);
  CallAPI(APIKey.GetSelfUserInfo, args);
}

export function SubscribeUsersStatus(cb: (result: List<OnlineStatus>, errCode: number, errMsg: string) => void,
  userIds: string[]): void {
  const args = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<List<OnlineStatus>>(args.operationId, cb);
  CallAPI(APIKey.SubscribeUsersStatus, args);
}

export function UnsubscribeUsersStatus(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIds: string[]): void {
  const args = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.UnsubscribeUsersStatus, args);
}

export function GetSubscribeUsersStatus(cb: (result: List<OnlineStatus>, errCode: number,
  errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<List<OnlineStatus>>(args.operationId, cb);
  CallAPI(APIKey.GetSubscribeUsersStatus, args);
}

export function GetUserStatus(cb: (result: List<OnlineStatus>, errCode: number, errMsg: string) => void,
  userIds: string[]): void {
  const args = {
    operationId: GetOperationId(),
    userIds: JSON.stringify(userIds)
  };

  registerHandler<List<OnlineStatus>>(args.operationId, cb);
  CallAPI(APIKey.GetUserStatus, args);
}

export function GetSpecifiedFriendsInfo(cb: (result: List<FriendInfo>, errCode: number, errMsg: string) => void,
  userIdList: string[], filterBlack: boolean): void {
  const args = {
    operationId: GetOperationId(),
    userIdList: JSON.stringify(userIdList),
    filterBlack
  };

  registerHandler<List<FriendInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetSpecifiedFriendsInfo, args);
}

export function GetFriendList(cb: (result: List<FriendInfo>, errCode: number, errMsg: string) => void,
  filterBlack: boolean): void {
  const args = {
    operationId: GetOperationId(),
    filterBlack
  };

  registerHandler<List<FriendInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetFriendList, args);
}

export function GetFriendListPage(cb: (result: List<FriendInfo>, errCode: number, errMsg: string) => void,
  offset: number, count: number, filterBlack: boolean): void {
  const args = {
    operationId: GetOperationId(),
    offset,
    count,
    filterBlack
  };

  registerHandler<List<FriendInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetFriendListPage, args);
}

export function SearchFriends(cb: (result: List<SearchFriendItem>, errCode: number, errMsg: string) => void,
  searchParam: SearchFriendsParam): void {
  const args = {
    operationId: GetOperationId(),
    searchParam: JSON.stringify(searchParam)
  };

  registerHandler<List<SearchFriendItem>>(args.operationId, cb);
  CallAPI(APIKey.SearchFriends, args);
}

export function UpdateFriends(cb: (result: boolean, errCode: number, errMsg: string) => void,
  req: UpdateFriendsReq): void {
  const args = {
    operationId: GetOperationId(),
    req: JSON.stringify(req)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.UpdateFriends, args);
}

export function CheckFriend(cb: (result: List<UserIDResult>, errCode: number, errMsg: string) => void,
  userIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    userIdList: JSON.stringify(userIdList)
  };

  registerHandler<List<UserIDResult>>(args.operationId, cb);
  CallAPI(APIKey.CheckFriend, args);
}

export function AddFriend(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIdReqMsg: ApplyToAddFriendReq): void {
  const args = {
    operationId: GetOperationId(),
    userIdReqMsg: JSON.stringify(userIdReqMsg)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AddFriend, args);
}

export function DeleteFriend(cb: (result: boolean, errCode: number, errMsg: string) => void,
  friendUserId: string): void {
  const args = {
    operationId: GetOperationId(),
    friendUserId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DeleteFriend, args);
}

export function GetFriendApplicationListAsRecipient(cb: (result: List<FriendApplicationInfo>, errCode: number,
  errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<List<FriendApplicationInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetFriendApplicationListAsRecipient, args);
}

export function GetFriendApplicationListAsApplicant(cb: (result: List<FriendApplicationInfo>, errCode: number,
  errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<List<FriendApplicationInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetFriendApplicationListAsApplicant, args);
}

export function AcceptFriendApplication(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIdHandleMsg: ProcessFriendApplicationParams): void {
  const args = {
    operationId: GetOperationId(),
    userIdHandleMsg: JSON.stringify(userIdHandleMsg)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AcceptFriendApplication, args);
}

export function RefuseFriendApplication(cb: (result: boolean, errCode: number, errMsg: string) => void,
  userIdHandleMsg: ProcessFriendApplicationParams): void {
  const args = {
    operationId: GetOperationId(),
    userIdHandleMsg: JSON.stringify(userIdHandleMsg)
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RefuseFriendApplication, args);
}

export function AddBlack(cb: (result: boolean, errCode: number, errMsg: string) => void, blackUserId: string,
  ex: string): void {
  const args = {
    operationId: GetOperationId(),
    blackUserId,
    ex
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.AddBlack, args);
}

export function GetBlackList(cb: (result: List<BlackInfo>, errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<List<BlackInfo>>(args.operationId, cb);
  CallAPI(APIKey.GetBlackList, args);
}

export function RemoveBlack(cb: (result: boolean, errCode: number, errMsg: string) => void,
  removeUserId: string): void {
  const args = {
    operationId: GetOperationId(),
    removeUserId
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.RemoveBlack, args);
}

export function CreateGroup(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupReqInfo: CreateGroupReq): void {
  const args = {
    operationId: GetOperationId(),
    groupReqInfo: Utils.ToJson(groupReqInfo),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.CreateGroup, args);
}

export function JoinGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  reqMsg: string, joinSource: JoinSource, ex: string): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    reqMsg,
    joinSource: joinSource as number,
    ex,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.JoinGroup, args);
}

export function QuitGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.QuitGroup, args);
}

export function DismissGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.DismissGroup, args);
}

export function ChangeGroupMute(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  isMute: boolean): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    isMute,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.ChangeGroupMute, args);
}

export function ChangeGroupMemberMute(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  userId: string, mutedSeconds: number): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    userId,
    mutedSeconds,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.ChangeGroupMemberMute, args);
}

export function SetGroupMemberInfo(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupMemberInfo: SetGroupMemberInfo): void {
  const args = {
    operationId: GetOperationId(),
    groupMemberInfo: Utils.ToJson(groupMemberInfo),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetGroupMemberInfo, args);
}

export function GetJoinedGroupList(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetJoinedGroupList, args);
}

export function GetJoinedGroupListPage(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void,
  offset: number, count: number): void {
  const args = {
    operationId: GetOperationId(),
    offset,
    count,
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetJoinedGroupListPage, args);
}

export function GetSpecifiedGroupsInfo(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void,
  groupIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    groupIdList: Utils.ToJson(groupIdList),
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetSpecifiedGroupsInfo, args);
}

export function SearchGroups(cb: (result: GroupInfo[], errCode: number, errMsg: string) => void,
  searchParam: SearchGroupsParam): void {
  const args = {
    operationId: GetOperationId(),
    searchParam: Utils.ToJson(searchParam),
  };

  registerHandler<GroupInfo[]>(args.operationId, cb);
  CallAPI(APIKey.SearchGroups, args);
}

export function SetGroupInfo(cb: (result: boolean, errCode: number, errMsg: string) => void,
  groupInfo: GroupInfoForSet): void {
  const args = {
    operationId: GetOperationId(),
    groupInfo: Utils.ToJson(groupInfo),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.SetGroupInfo, args);
}

export function GetGroupMemberList(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string, filter: GroupMemberFilter, offset: number, count: number): void {
  const args = {
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
  const args = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupMemberOwnerAndAdmin, args);
}

export function GetGroupMemberListByJoinTimeFilter(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string, offset: number, count: number, joinTimeBegin: number, joinTimeEnd: number,
  filterUserIDList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    offset,
    count,
    joinTimeBegin,
    joinTimeEnd,
    filterUserIdList: Utils.ToJson(filterUserIDList),
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupMemberListByJoinTimeFilter, args);
}

export function GetSpecifiedGroupMembersInfo(cb: (result: GroupMember[], errCode: number, errMsg: string) => void,
  groupId: string, userIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    userIdList: Utils.ToJson(userIdList),
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.GetSpecifiedGroupMembersInfo, args);
}

export function KickGroupMember(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  reason: string, userIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    reason,
    userIdList: Utils.ToJson(userIdList),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.KickGroupMember, args);
}

export function TransferGroupOwner(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  newOwnerUserId: string): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    newOwnerUserId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.TransferGroupOwner, args);
}

export function InviteUserToGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  reason: string, userIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    reason,
    userIdList: Utils.ToJson(userIdList),
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.InviteUserToGroup, args);
}

export function GetGroupApplicationListAsRecipient(cb: (result: GroupApplicationInfo[], errCode: number,
  errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<GroupApplicationInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupApplicationListAsRecipient, args);
}

export function GetGroupApplicationListAsApplicant(cb: (result: GroupApplicationInfo[], errCode: number,
  errMsg: string) => void): void {
  const args = {
    operationId: GetOperationId(),
  };

  registerHandler<GroupApplicationInfo[]>(args.operationId, cb);
  CallAPI(APIKey.GetGroupApplicationListAsApplicant, args);
}

export function AcceptGroupApplication(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string,
  fromUserId: string, handleMsg: string): void {
  const args = {
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
  const args = {
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
  const args = {
    operationId: GetOperationId(),
    searchParam: Utils.ToJson(searchParam),
  };

  registerHandler<GroupMember[]>(args.operationId, cb);
  CallAPI(APIKey.SearchGroupMembers, args);
}

export function IsJoinGroup(cb: (result: boolean, errCode: number, errMsg: string) => void, groupId: string): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
  };

  registerHandler<boolean>(args.operationId, cb);
  CallAPI(APIKey.IsJoinGroup, args);
}

export function GetUsersInGroup(cb: (result: string[], errCode: number, errMsg: string) => void, groupId: string,
  userIdList: string[]): void {
  const args = {
    operationId: GetOperationId(),
    groupId,
    userIdList,
  };

  registerHandler<string[]>(args.operationId, cb);
  CallAPI(APIKey.GetUsersInGroup, args);
}








