import { openim as proto } from "./proto/proto"
import { internal_Init, call } from "./native/NativeSDK"
import logger from "./utils/Logger"
import { event } from "./EventHandler";
import { listener } from "./Listener"

export namespace imsdk {
  let handleId = 0

  function genHandleId(): number {
    handleId = handleId + 1
    return handleId
  }

  export function SetErrCallBack(callBack: event.ErrCallBack) {
    event.SetErrCallBack(callBack)
  }

  export function SetConnListener(conn: listener.ConnListener) {
    event.SetConnListener(conn)
  }

  export function SetUserListener(conn: listener.UserListener) {
    event.SetUserListener(conn)
  }

  export function SetConversationListener(conn: listener.ConversationListener) {
    event.SetConversationListener(conn)
  }

  export function SetFriendShipListener(conn: listener.FriendShipListener) {
    event.SetFriendShipListener(conn)
  }

  export function SetGroupListener(conn: listener.GroupListener) {
    event.SetGroupListener(conn)
  }

  export function SetMessageListener(conn: listener.MessageListener) {
    event.SetMessageListener(conn)
  }


  export function Version(cb: (version: string) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.init.VersionReq.create()
    call(handleId, proto.event.FuncRequestEventName.Version, proto.init.VersionReq.encode(req).finish())
  }

  export function InitSDK(callback: (suc: boolean) => void, config: proto.init.IMConfig) {

    internal_Init(event.DispatchEvent)

    let req = proto.init.InitSDKReq.create({
      config: config
    })

    let handleId = genHandleId()
    event.RegisterCallBack(handleId, callback)
    call(handleId, proto.event.FuncRequestEventName.InitSDK, proto.init.InitSDKReq.encode(req).finish())
  }

  export function Login(cb: (suc: boolean) => void, uid: string, token: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.init.LoginReq.create({
      userID: uid,
      token: token,
    })
    call(handleId, proto.event.FuncRequestEventName.Login, proto.init.LoginReq.encode(req).finish())
  }

  export function Logout(cb: (suc: boolean) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.init.LogoutReq.create()
    call(handleId, proto.event.FuncRequestEventName.Logout, proto.init.LogoutReq.encode(req).finish())
  }

  export function SetAppBackGroundStatu(cb: (suc: boolean) => void, isBackground: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.init.SetAppBackgroundStatusReq.create({
      isBackground = isBackground
    })
    call(handleId, proto.event.FuncRequestEventName.SetAppBackgroundStatus,
      proto.init.SetAppBackgroundStatusReq.encode(req).finish());
  }

  export function NetworkStatusChanged(cb: (suc: boolean) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.init.NetworkStatusChangedReq.create()
    call(handleId, proto.event.FuncRequestEventName.NetworkStatusChanged,
      proto.init.NetworkStatusChangedReq.encode(req).finish())
  }

  export function GetLoginStatus(cb: (status: proto.init.LoginStatus) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.init.GetLoginStatusReq.create()
    call(handleId, proto.event.FuncRequestEventName.GetLoginStatus, proto.init.GetLoginStatusReq.encode(req).finish())
  }

  export function CreateTextMessage(cb: (msg: proto.sdk.shared.IIMMessage) => void, text: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateTextMessageReq.create({
      text: text
    })
    call(handleId, proto.event.FuncRequestEventName.CreateTextMessage,
      proto.sdk.message.CreateTextMessageReq.encode(req)
        .finish())
  }

  export function CreateAdvancedTextMessage(cb: (msg: proto.sdk.shared.IIMMessage) => void, text: string,
    messageEntityList: proto.sdk.shared.IMessageEntity[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateAdvancedTextMessageReq.create({
      text: text,
      messageEntities: messageEntityList
    })
    call(handleId, proto.event.FuncRequestEventName.CreateAdvancedTextMessage,
      proto.sdk.message.CreateAdvancedTextMessageReq.encode(req)
        .finish());
  }

  export function CreateTextAtMessage(cb: (msg: proto.sdk.shared.IIMMessage) => void, text: string,
    atUserList: string[], atUsersInfo: proto.sdk.shared.IAtInfo[], message: proto.sdk.shared.IIMMessage) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateTextAtMessageReq.create({
      text: text,
      userIDList: atUserList,
      usersInfo: atUsersInfo,
      quoteMessage: message
    })
    call(handleId, proto.event.FuncRequestEventName.CreateTextAtMessage,
      proto.sdk.message.CreateTextAtMessageReq.encode(req)
        .finish());
  }

  export function CreateLocationMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, description: string,
    longitude: number, latitude: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateLocationMessageReq.create({
      description = description,
      longitude = longitude,
      latitude = latitude
    })
    call(handleId, proto.event.FuncRequestEventName.CreateLocationMessage,
      proto.sdk.message.CreateLocationMessageReq.encode(req)
        .finish())

  }

  export function CreateCustomMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, data: string, extension: string,
    description: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateCustomMessageReq.create({
      data = data,
      extension = extension,
      description = description
    })
    call(handleId, proto.event.FuncRequestEventName.CreateCustomMessage,
      proto.sdk.message.CreateCustomMessageReq.encode(req)
        .finish())
  }

  export function CreateQuoteMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, text: string,
    message: proto.sdk.shared.IIMMessage) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateQuoteMessageReq.create({
      text = text,
      quoteMessage = message
    })
    call(handleId, proto.event.FuncRequestEventName.CreateQuoteMessage,
      proto.sdk.message.CreateQuoteMessageReq.encode(req)
        .finish())
  }

  export function CreateAdvancedQuoteMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, text: string,
    message: proto.sdk.shared.IIMMessage, messageEntityList: proto.sdk.shared.IMessageEntity[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateAdvancedQuoteMessageReq.create({
      text = text,
      quoteMessage = message,
      messageEntities = messageEntityList
    })
    call(handleId, proto.event.FuncRequestEventName.CreateAdvancedQuoteMessage,
      proto.sdk.message.CreateAdvancedQuoteMessageReq.encode(req)
        .finish());
  }

  export function CreateCardMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, card: proto.sdk.shared.ICardElem) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateCardMessageReq.create({
      userID = card.userID,
      nickname = card.nickname,
      faceURL = card.faceURL,
      ex = card.ex
    })
    call(handleId, proto.event.FuncRequestEventName.CreateCardMessage,
      proto.sdk.message.CreateCardMessageReq.encode(req)
        .finish())
  }

  export function CreateImageMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, imagePath: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateImageMessageReq.create({
      imageSourcePath = imagePath
    })
    call(handleId, proto.event.FuncRequestEventName.CreateImageMessage,
      proto.sdk.message.CreateImageMessageReq.encode(req)
        .finish())
  }

  export function CreateSoundMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, soundPath: string,
    duration: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateSoundMessageReq.create({
      soundPath = soundPath,
      duration = duration
    })
    call(handleId, proto.event.FuncRequestEventName.CreateSoundMessage,
      proto.sdk.message.CreateSoundMessageReq.encode(req)
        .finish())
  }

  export function CreateVideoMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, videoPath: string,
    videoType: string, duration: number,
    snapshotPath: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateVideoMessageReq.create({
      videoSourcePath = videoPath,
      videoType = videoType,
      duration = duration,
      snapshotSourcePath = snapshotPath
    })
    call(handleId, proto.event.FuncRequestEventName.CreateVideoMessage,
      proto.sdk.message.CreateVideoMessageReq.encode(req)
        .finish())
  }

  export function CreateFileMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, filePath: string,
    fileName: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateFileMessageReq.create({
      fileSourcePath = filePath,
      fileName = fileName
    })
    call(handleId, proto.event.FuncRequestEventName.CreateFileMessage,
      proto.sdk.message.CreateFileMessageReq.encode(req)
        .finish())
  }

  export function CreateMergerMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void,
    messages: proto.sdk.shared.IIMMessage[], title: string, summarys: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateMergerMessageReq.create({
      title = title,
      messages = messages,
      summaries = summarys
    })
    call(handleId, proto.event.FuncRequestEventName.CreateMergerMessage,
      proto.sdk.message.CreateMergerMessageReq.encode(req)
        .finish());
  }

  export function CreateFaceMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, index: number, data: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateFaceMessageReq.create({
      index = index,
      data = data,
    })
    call(handleId, proto.event.FuncRequestEventName.CreateFaceMessage,
      proto.sdk.message.CreateFaceMessageReq.encode(req)
        .finish())
  }

  export function CreateForwardMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void,
    message: proto.sdk.shared.IIMMessage) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateForwardMessageReq.create({
      message = message
    })
    call(handleId, proto.event.FuncRequestEventName.CreateForwardMessage,
      proto.sdk.message.CreateForwardMessageReq.encode(req)
        .finish())
  }

  export function GetAllConversationList(cb: (conversations: proto.sdk.shared.IIMConversation[]) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetAllConversationListReq.create()
    call(handleId, proto.event.FuncRequestEventName.GetAllConversationList,
      proto.sdk.conversation.GetAllConversationListReq.encode(req)
        .finish())
  }

  export function GetConversationListSplit(cb: (conversations: proto.sdk.shared.IIMConversation[]) => void,
    offset: number, count: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetConversationListSplitReq.create({
      offset = offset,
      count = count,
    })
    call(handleId, proto.event.FuncRequestEventName.GetConversationListSplit,
      proto.sdk.conversation.GetConversationListSplitReq.encode(req)
        .finish())
  }

  export function GetOneConversation(cb: (conversations: proto.sdk.shared.IIMConversation) => void,
    sessionType: proto.sdk.common.SessionType, sourceId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetOneConversationReq.create({
      sessionType = sessionType,
      sourceID = sourceId,
    })
    call(handleId, proto.event.FuncRequestEventName.GetOneConversation,
      proto.sdk.conversation.GetOneConversationReq.encode(req)
        .finish())
  }

  export function GetMultipleConversation(cb: (conversations: proto.sdk.shared.IIMConversation[]) => void,
    conversationIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetMultipleConversationReq.create({
      conversationIDList = conversationIds
    })
    call(handleId, proto.event.FuncRequestEventName.GetMultipleConversation,
      proto.sdk.conversation.GetMultipleConversationReq.encode(req)
        .finish());
  }

  export function HideConversation(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.HideConversationReq.create({
      conversationID = conversationId
    })
    call(handleId, proto.event.FuncRequestEventName.HideConversation,
      proto.sdk.conversation.HideConversationReq.encode(req)
        .finish())
  }

  export function HideAllConversations(cb: (suc: boolean) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.HideAllConversationsReq.create()
    call(handleId, proto.event.FuncRequestEventName.HideAllConversations,
      proto.sdk.conversation.HideAllConversationsReq.encode(req)
        .finish())
  }

  export function SetConversation(cb: (suc: boolean) => void, req: proto.sdk.conversation.ISetConversationReq) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);

    call(handleId, proto.event.FuncRequestEventName.SetConversation,
      proto.sdk.conversation.SetConversationDraftReq.encode(req)
        .finish());
  }

  export function SetConversationDraft(cb: (suc: boolean) => void, conversationId: string, draftText: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.SetConversationDraftReq.create({
      conversationID = conversationId,
      draftText = draftText,
    })
    call(handleId, proto.event.FuncRequestEventName.SetConversationDraft,
      proto.sdk.conversation.SetConversationDraftReq.encode(req)
        .finish())
  }

  export function GetTotalUnreadMsgCount(cb: (count: number) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetTotalUnreadMsgCountReq.create()
    call(handleId, proto.event.FuncRequestEventName.GetTotalUnreadMsgCount,
      proto.sdk.conversation.GetTotalUnreadMsgCountReq.encode(req)
        .finish())
  }

  export function GetAtAllTag(cb: (tag: string) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetAtAllTagReq.create()
    call(handleId, proto.event.FuncRequestEventName.GetAtAllTag, proto.sdk.conversation.GetAtAllTagReq.encode(req)
      .finish())
  }

  export function GetConversationIDBySessionType(cb: (conversationId: string) => void, sourceId: string,
    sessionType: proto.sdk.common.SessionType) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetConversationIDBySessionTypeReq.create({
      sourceID = sourceId,
      sessionType = sessionType,
    })
    call(handleId, proto.event.FuncRequestEventName.GetConversationIDBySessionType,
      proto.sdk.conversation.GetConversationIDBySessionTypeReq.encode(req)
        .finish())
  }

  // export function SendMessage (ISendMsg cb, IMMessage message, string recvId, string groupId, bool isOnlineOnly)
  // {
  //   let handleId = genHandleId();
  //   sendMsgevent.RegisterCallBack(handleId, cb);
  //   call(handleId, proto.event.FuncRequestEventName.SendMessage, new SendMessageReq
  //   {
  //     Message = message,
  //     RecvID = recvId,
  //     GroupID = groupId,
  //     IsOnlineOnly = isOnlineOnly,
  //   }
  //   )
  // }

  export function FindMessageList(cb: (count: number,
    data: proto.sdk.conversation.ISearchByConversationResult[]) => void,
    args: proto.sdk.conversation.IConversationArgs[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.FindMessageListReq.create({
      conversationsArgs = args
    });
    call(handleId, proto.event.FuncRequestEventName.FindMessageList,
      proto.sdk.conversation.FindMessageListReq.encode(req)
        .finish());
  }

  // export function GetHistoryMessageList( )=>void, string conversationId, string startClientMsgId, int count, bool isReverse)
  // {
  //   let handleId = genHandleId();
  //   event.RegisterCallBack(handleId, cb);
  //   call(handleId, proto.event.FuncRequestEventName.GetHistoryMessageList, new GetHistoryMessageListReq
  //   {
  //     ConversationID = conversationId,
  //     StartClientMsgID = startClientMsgId,
  //     Count = count,
  //     IsReverse = isReverse,
  //   }
  //   )
  //   ;
  // }

  export function RevokeMessage(cb: (suc: boolean) => void, conversationId: string, clientMsgId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.RevokeMessageReq.create({
      conversationID = conversationId,
      clientMsgID = clientMsgId
    })
    call(handleId, proto.event.FuncRequestEventName.RevokeMessage, proto.sdk.message.RevokeMessageReq.encode(req)
      .finish())
  }

  export function TypingStatusUpdate(cb: (suc: boolean) => void, recvId: string, msgTip: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.TypingStatusUpdateReq.create({
      recvID = recvId,
      msgTip = msgTip
    })
    call(handleId, proto.event.FuncRequestEventName.TypingStatusUpdate,
      proto.sdk.message.TypingStatusUpdateReq.encode(req)
        .finish())
  }

  export function MarkConversationMessageAsRead(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.MarkConversationMessageAsReadReq.create({
      conversationID = conversationId
    })
    call(handleId, proto.event.FuncRequestEventName.MarkConversationMessageAsRead,
      proto.sdk.conversation.MarkConversationMessageAsReadReq.encode(req)
        .finish())
  }

  export function MarkAllConversationMessageAsRead(cb: (suc: boolean) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.MarkAllConversationMessageAsReadReq.create()
    call(handleId, proto.event.FuncRequestEventName.MarkAllConversationMessageAsRead,
      proto.sdk.conversation.MarkAllConversationMessageAsReadReq.encode(req)
        .finish())
  }

  export function DeleteMessageFromLocal(cb: (suc: boolean) => void, conversationId: string, clientMsgId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.DeleteAllMessageFromLocalReq.create({
      conversationID = conversationId,
      clientMsgID = clientMsgId
    })
    call(handleId, proto.event.FuncRequestEventName.DeleteMessageFromLocal,
      proto.sdk.message.DeleteAllMessageFromLocalReq.encode(req)
        .finish())
  }

  export function DeleteMessage(cb: (suc: boolean) => void, conversationId: string, clientMsgId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.DeleteMessageReq.create({
      conversationID = conversationId,
      clientMsgID = clientMsgId
    })
    call(handleId, proto.event.FuncRequestEventName.DeleteMessage, proto.sdk.message.DeleteMessageReq.encode(req)
      .finish())
  }

  export function DeleteAllMsgFromLocalAndServer(cb: (suc: boolean) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.DeleteAllMsgFromLocalAndServerReq.create()
    call(handleId, proto.event.FuncRequestEventName.DeleteAllMsgFromLocalAndServer,
      proto.sdk.message.DeleteAllMsgFromLocalAndServerReq.encode(req)
        .finish())
  }

  export function DeleteAllMessageFromLocal(cb: (suc: boolean) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.DeleteAllMessageFromLocalReq.create()
    call(handleId, proto.event.FuncRequestEventName.DeleteAllMessageFromLocal,
      proto.sdk.message.DeleteAllMessageFromLocalReq.encode(req)
        .finish())
  }

  export function ClearConversationAndDeleteAllMsg(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.ClearConversationAndDeleteAllMsgReq.create({
      conversationID = conversationId
    })
    call(handleId, proto.event.FuncRequestEventName.ClearConversationAndDeleteAllMsg,
      proto.sdk.conversation.ClearConversationAndDeleteAllMsgReq.encode(req)
        .finish())
  }

  export function DeleteConversationAndDeleteAllMsg(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.DeleteConversationAndDeleteAllMsgReq.create({
      conversationID = conversationId
    })
    call(handleId, proto.event.FuncRequestEventName.DeleteConversationAndDeleteAllMsg,
      proto.sdk.conversation.DeleteConversationAndDeleteAllMsgReq.encode(req)
        .finish())
  }

  export function InsertSingleMessageToLocal(cb: (msg: proto.sdk.shared.IIMMessage) => void,
    message: proto.sdk.shared.IIMMessage, recvId: string, sendId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.InsertSingleMessageToLocalReq.create({
      msg = message,
      recvID = recvId,
      sendID = sendId
    })
    call(handleId, proto.event.FuncRequestEventName.InsertSingleMessageToLocal,
      proto.sdk.message.InsertSingleMessageToLocalReq.encode(req)
        .finish())
  }

  export function InsertGroupMessageToLocalStorage(cb: (msg: proto.sdk.shared.IIMMessage) => void,
    message: proto.sdk.shared.IIMMessage, groupId: string, sendId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.InsertGroupMessageToLocalReq.create({
      msg = message,
      groupID = groupId,
      sendID = sendId
    })
    call(handleId, proto.event.FuncRequestEventName.InsertGroupMessageToLocal,
      proto.sdk.message.InsertGroupMessageToLocalReq.encode(req)
        .finish())
  }

  // export function SearchLocalMessages(cb :(count: number, data:proto.sdk.conversation.ISearchByConversationResult[])=>void, searchParam:proto.sdk.conversation.Search)
  // {
  //   let handleId = genHandleId();
  //   event.RegisterCallBack(handleId, cb);
  //   let req = proto.sdk.message
  //   call(handleId, proto.event.FuncRequestEventName.SearchLocalMessages,)
  // }

  export function SearchConversation(cb: (conversations: proto.sdk.shared.IIMConversation[]) => void,
    searchParam: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.SearchConversationReq.create({
      searchParam = searchParam
    })
    call(handleId, proto.event.FuncRequestEventName.SearchConversation,
      proto.sdk.conversation.SearchConversationReq.encode(req)
        .finish())
  }

  export function SetMessageLocalEx(cb: (suc: boolean) => void, conversationId: string, clientMsgId: string,
    localEx: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.SetMessageLocalExReq.create({
      conversationID = conversationId,
      clientMsgID = clientMsgId,
      localEx = localEx
    })
    call(handleId, proto.event.FuncRequestEventName.SetMessageLocalEx,
      proto.sdk.conversation.SetMessageLocalExReq.encode(req)
        .finish())
  }

  export function GetUsersInfo(cb: (user: proto.sdk.shared.IIMUser[]) => void, userIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.GetUsersInfoReq.create({
      userIDs = userIds
    })
    call(handleId, proto.event.FuncRequestEventName.GetUsersInfo, proto.sdk.user.GetSelfUserInfoReq.encode(req)
      .finish());
  }

  export function SetSelfInfo(cb: (suc: boolean) => void, req: proto.sdk.user.ISetSelfInfoReq) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SetSelfInfo, proto.sdk.user.SetSelfInfoReq.encode(req)
      .finish());
  }

  export function GetSelfUserInfo(cb: (user: proto.sdk.shared.IIMUser) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.GetSelfUserInfoReq.create()
    call(handleId, proto.event.FuncRequestEventName.GetSelfUserInfo, proto.sdk.user.GetSelfUserInfoReq.encode(req)
      .finish());
  }

  export function SubscribeUsersOnlineStatus(cb: (platforms: proto.sdk.conversation.UserOnlinePlatform[]) => void,
    userIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.SubscribeUsersOnlineStatusReq.create({
      userIDs = userIds
    })
    call(handleId, proto.event.FuncRequestEventName.SubscribeUsersOnlineStatus,
      proto.sdk.conversation.SubscribeUsersOnlineStatusReq.encode(req)
        .finish());
  }

  export function UnsubscribeUsersOnlineStatus(cb: (suc: boolean) => void, userIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.UnsubscribeUsersOnlineStatusReq.create({
      userIDs = userIds
    })
    call(handleId, proto.event.FuncRequestEventName.UnsubscribeUsersOnlineStatus,
      proto.sdk.conversation.UnsubscribeUsersOnlineStatusReq.encode(req)
        .finish());
  }

  export function ProcessUserCommandGetAll(cb: (commands: proto.sdk.shared.ICommandInfo[]) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.ProcessUserCommandGetAllReq.create()
    call(handleId, proto.event.FuncRequestEventName.ProcessUserCommandGetAll,
      proto.sdk.user.ProcessUserCommandGetAllReq.encode(req)
        .finish())
  }

  export function ProcessUserCommandAdd(cb: (suc: boolean) => void, userId: string, type: number, uuid: string,
    value: string, ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.ProcessUserCommandAddReq.create({
      userID = userId,
      type = type,
      uuid = uuid,
      value = value,
      ex = ex
    })
    call(handleId, proto.event.FuncRequestEventName.ProcessUserCommandAdd,
      proto.sdk.user.ProcessUserCommandAddReq.encode(req)
        .finish())
  }

  export function ProcessUserCommandDelete(cb: (suc: boolean) => void, userId: string, type: number, uuid: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.ProcessUserCommandDeleteReq.create({
      userID = userId,
      type = type,
      uuid = uuid,
    })
    call(handleId, proto.event.FuncRequestEventName.ProcessUserCommandDelete,
      proto.sdk.user.ProcessUserCommandDeleteReq.encode(req)
        .finish())
  }

  export function ProcessUserCommandUpdate(cb: (suc: boolean) => void, userId: string, type: number, uuid: string,
    value: string, ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.ProcessUserCommandUpdateReq.create({
      userID = userId,
      type = type,
      uuid = uuid,
      value = value,
      ex = ex
    })
    call(handleId, proto.event.FuncRequestEventName.ProcessUserCommandUpdate,
      proto.sdk.user.ProcessUserCommandUpdateReq.encode(req)
        .finish())
  }

  export function GetSpecifiedFriends(cb: (friends: proto.sdk.shared.IIMFriend[]) => void, userIdList: string[],
    filterBlack: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetSpecifiedFriendsReq.create({
      filterBlack = filterBlack,
      friendUserIDs = userIdList,
    })
    call(handleId, proto.event.FuncRequestEventName.GetSpecifiedFriends,
      proto.sdk.relation.GetSpecifiedFriendsReq.encode(req)
        .finish());
  }

  export function GetFriends(cb: (friends: proto.sdk.shared.IIMFriend[]) => void, filterBlack: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetFriendsReq.create({
      filterBlack = filterBlack
    })
    call(handleId, proto.event.FuncRequestEventName.GetFriends, proto.sdk.relation.GetFriendsReq.encode(req)
      .finish())
  }

  export function GetFriendsPage(cb: (friends: proto.sdk.shared.IIMFriend[]) => void, pageNumber: number,
    showNumber: number, filterBlack: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetFriendsPageReq.create({
      filterBlack = filterBlack,
      pagination = proto.sdk.common.RequestPagination.create({
        pageNumber = pageNumber,
        showNumber = showNumber,
      })
    })
    call(handleId, proto.event.FuncRequestEventName.GetFriendsPage, proto.sdk.relation.GetFriendsPageReq.encode(req)
      .finish())
  }

  export function SearchFriends(cb: (info: proto.sdk.relation.ISearchFriendsInfo[]) => void, keyWord: string,
    searchUserId: boolean, searchNickName: boolean, searchRemark: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.SearchFriendsReq.create({
      keyword = keyWord,
      searchUserID = searchUserId,
      searchNickname = searchNickName,
      searchRemark = searchRemark
    })
    call(handleId, proto.event.FuncRequestEventName.SearchFriends, proto.sdk.relation.SearchFriendsReq.encode(req)
      .finish())
  }

  export function UpdateFriend(cb: (suc: boolean) => void, userId: string, pinned: boolean, remark: string,
    ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.UpdateFriendReq.create({
      userID = userId,
      pinned = pinned,
      Remark = remark,
      ex = ex,
    })
    call(handleId, proto.event.FuncRequestEventName.UpdateFriend, proto.sdk.relation.UpdateFriendReq.encode(req)
      .finish())
  }

  export function CheckFriend

  (Action<CheckFriendInfo[] > cb, string[] userIdList)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new CheckFriendReq
    {
    }
    ;
    req.FriendUserIDs.Add(userIdList);
    call(handleId, proto.event.FuncRequestEventName.CheckFriend, req);
  }

  export function AddFriend

  (cb:(suc: boolean) => void, string userId, string reqMsg, string ex)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.AddFriend, new AddFriendReq
    {
      UserID = userId,
      ReqMsg = reqMsg,
      Ex = ex,
    }
    )
    ;
  }

  export function DeleteFriend

  (cb:(suc: boolean) => void, string friendUserId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.DeleteFriend, new DeleteFriendReq
    {
      UserID = friendUserId
    }
    )
    ;
  }

  export function GetFriendsRequest

  (Action<IMFriendApplication[] > cb, bool send)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetFriendRequests, new GetFriendRequestsReq
    {
      Send = send
    }
    )
    ;
  }

  export function HandleFriendRequest

  (cb:(suc: boolean) => void, string userId, string handleMsg, ApprovalStatus status)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.HandleFriendRequest, new HandleFriendRequestReq
    {
      UserID = userId,
      HandleMsg = handleMsg,
      Status = status,
    }
    )
    ;
  }

  export function AddBlack

  (cb:(suc: boolean) => void, string userId, string ex)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.AddBlack, new AddBlackReq
    {
      UserID = userId,
      Ex = ex
    }
    )
    ;
  }

  export function GetBlacks

  (Action<IMBlack[] > cb)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetBlacks, new GetBlacksReq
    {
    }
    )
    ;
  }

  export function DeleteBlack

  (cb:(suc: boolean) => void, string removeUserId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.DeleteBlack, new DeleteBlackReq
    {
      UserID = removeUserId
    }
    )
    ;
  }
  #endregion

  #region group

  export function CreateGroup

  (Action<IMGroup > cb, IMGroup group, string[] adminUserIds, string[] memeberUserIds)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new CreateGroupReq();
    req.GroupInfo = group;
    req.AdminUserIDs.Add(adminUserIds);
    req.MemberUserIDs.Add(memeberUserIds);
    call(handleId, proto.event.FuncRequestEventName.CreateGroup, req);
  }

  export function JoinGroup

  (cb:(suc: boolean) => void, string groupId, string reqMsg, GroupJoinSource joinSource, string ex)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.JoinGroup, new JoinGroupReq
    {
      GroupID = groupId,
      ReqMessage = reqMsg,
      JoinSource = joinSource,
      Ex = ex
    }
    )
    ;
  }

  export function QuitGroup

  (cb:(suc: boolean) => void, string groupId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.QuitGroup, new QuitGroupReq
    {
      GroupID = groupId
    }
    )
    ;
  }

  export function DismissGroup

  (cb:(suc: boolean) => void, string groupId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.DismissGroup, new DismissGroupReq
    {
      GroupID = groupId
    }
    )
    ;
  }

  export function ChangeGroupMute

  (cb:(suc: boolean) => void, string groupId, bool isMute)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.ChangeGroupMute, new ChangeGroupMuteReq
    {
      GroupID = groupId,
      Mute = isMute,
    }
    )
    ;
  }

  export function ChangeGroupMemberMute

  (cb:(suc: boolean) => void, string groupId, string userId, uint mutedSeconds)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.ChangeGroupMemberMute, new ChangeGroupMemberMuteReq
    {
      GroupID = userId,
      UserID = userId,
      MutedSeconds = mutedSeconds
    }
    )
    ;
  }

  export function SetGroupMemberInfo

  (Action<bool >
    cb, string groupId, string userId, string nickName, string faceUrl, int roleLevel, string ex)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SetGroupMemberInfo, new SetGroupMemberInfoReq
    {
      GroupID = groupId,
      UserID = userId,
      Nickname = nickName,
      RoleLevel = roleLevel,
      Ex = ex
    }
    )
    ;
  }

  export function GetJoinedGroups

  (Action<IMGroup[] > cb)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetJoinedGroups, new GetJoinedGroupsReq
    {
    }
    )
    ;
  }

  export function GetJoinedGroupsPage

  (Action<IMGroup[] > cb, int pageNumber, int showNumber)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetJoinedGroupsPage, new GetJoinedGroupsPageReq
    {
      Pagination = new RequestPagination
      {
        PageNumber = pageNumber,
        ShowNumber = showNumber
      }
    }
    )
    ;
  }

  export function GetSpecifiedGroupsInfo

  (Action<IMGroup[] > cb, string[] groupIdList)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new GetSpecifiedGroupsInfoReq();
    req.GroupIDs.Add(groupIdList);
    call(handleId, proto.event.FuncRequestEventName.GetSpecifiedGroupsInfo, req);
  }

  export function SearchGroups

  (Action<IMGroup[] > cb, string keyWord, bool searchGroupId, bool searchGroupName)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SearchGroups, new SearchGroupsReq
    {
      Keyword = keyWord,
      SearchGroupID = searchGroupId,
      SearchGroupName = searchGroupName
    }
    )
    ;
  }

  export function SetGroupInfo

  (cb:(suc: boolean) => void, SetGroupInfoReq req)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SetGroupInfo, req);
  }

  export function GetGroupMembers

  (Action<IMGroupMember[] >
    cb, string groupId, GroupFilter filter, int pageNumber, int showNumber)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetGroupMembers, new GetGroupMembersReq
    {
      GroupID = groupId,
      Filter = filter,
      Pagination = new RequestPagination
      {
        PageNumber = pageNumber,
        ShowNumber = showNumber
      }
    }
    )
    ;
  }

  export function GetGroupMemberOwnerAndAdmin

  (Action<IMGroupMember[] > cb, string groupId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetGroupMemberOwnerAndAdmin,
      new GetGroupMemberOwnerAndAdminReq
    {
      GroupID = groupId
    }
    )
    ;
  }

  export function GetGroupMembersByJoinTimeFilter

  (Action<IMGroupMember[] >
    cb, string groupId, long joinTimeBegin, long joinTimeEnd, int pageNumber, int showNumber)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new GetGroupMembersByJoinTimeFilterReq
    {
      GroupID = groupId,
      JoinTimeBegin = joinTimeBegin,
      JoinTimeEnd = joinTimeEnd,
      Pagination = new RequestPagination
      {
        PageNumber = pageNumber,
        ShowNumber = showNumber
      }
    }
    ;
    call(handleId, proto.event.FuncRequestEventName.GetGroupMembersByJoinTimeFilter, req);
  }

  export function GetSpecifiedGroupMembersInfo

  (Action<IMGroupMember[] > cb, string groupId, string[] userIdList)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new GetSpecifiedGroupMembersInfoReq
    {
      GroupID = groupId
    }
    ;
    req.UserIDs.Add(userIdList);
    call(handleId, proto.event.FuncRequestEventName.GetSpecifiedGroupMembersInfo, req);
  }

  export function KickGroupMember

  (cb:(suc: boolean) => void, string groupId, string reason, string[] userIdList)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new KickGroupMemberReq
    {
      GroupID = groupId,
      Reason = reason
    }
    ;
    req.KickedUserIDs.Add(userIdList);
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.KickGroupMember, req);
  }

  export function TransferGroupOwner

  (cb:(suc: boolean) => void, string groupId, string ownerUserId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.TransferGroupOwner, new TransferGroupOwnerReq
    {
      GroupID = groupId,
      OwnerUserID = ownerUserId
    }
    )
    ;
  }

  export function InviteUserToGroup

  (cb:(suc: boolean) => void, string groupId, string reason, string[] userIdList)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new InviteUserToGroupReq
    {
      GroupID = groupId,
      Reason = reason,
    }
    ;
    req.UserIDs.Add(userIdList);
    call(handleId, proto.event.FuncRequestEventName.InviteUserToGroup, req);
  }

  export function GetGroupRequest

  (Action<IMGroupApplication[] > cb, bool send)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.GetGroupRequest, new GetGroupRequestReq
    {
      Send = send
    }
    )
    ;
  }

  export function HandlerGroupRequest

  (Action<bool >
    cb, string groupId, string fromUserId, string handleMsg, ApprovalStatus status)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.HandleGroupRequest, new HandleGroupRequestReq
    {
      GroupID = groupId,
      FromUserID = fromUserId,
      HandledMsg = handleMsg,
      Status = status,
    }
    )
    ;
  }

  export function SearchGroupMembers

  (Action<IMGroupMember >
    cb, string groupId, string keyWord, bool searchUserId, bool searchNickName, int pageNumber, int showNumber)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SearchGroupMembers, new SearchGroupMembersReq
    {
      GroupID = groupId,
      Keyword = keyWord,
      SearchUserID = searchUserId,
      SearchMemberNickname = searchNickName,
      Pagination = new RequestPagination
      {
        PageNumber = pageNumber,
        ShowNumber = showNumber
      }
    }
    )
    ;
  }

  export function IsJoinGroup

  (cb:(suc: boolean) => void, string groupId)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.IsJoinGroup, new IsJoinGroupReq
    {
      GroupID = groupId
    }
    )
    ;
  }

  export function GetUsersInGroup

  (Action<string[] > cb, string groupId, string[] userIdList)
  {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = new GetUsersInGroupReq
    {
      GroupID = groupId,
    }
    ;
    req.UserIDs.Add(userIdList);
    call(handleId, proto.event.FuncRequestEventName.GetUsersInGroup, req);
  }
  #endregion

  export function UploadLogs

  (IUploadLogs cb, int line, string ex, UploadSDKDataMode mode)
  {
    let handleId = genHandleId();
    uploadLogsevent.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.UploadLogs, new UploadSDKDataReq
    {
      Line = line,
      Ex = ex,
      Mode = mode
    }
    )
    ;
  }

  export function UploadFile

  (IUploadFile cb, string filePath, string name, string mimeType, string fileCategory)
  {
    let handleId = genHandleId();
    uploadFileevent.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.UploadFile, new UploadFileReq
    {
      Filepath = filePath,
      Name = name,
      MimeType = mimeType,
      FileCategory = fileCategory
    }
    )
    ;
  }

  export function Log

  (LogLevel level, string file, int line, string msg, string err, LogKv[] kvs)
  {
    let handleId = genHandleId();
    let req = new LogReq
    {
      LogLevel = level,
      File = file,
      Line = line,
      Msg = msg,
      Err = err,
    }
    ;
    req.Kvs.Add(kvs);
    call(handleId, proto.event.FuncRequestEventName.Log, req);
  }
}
}





