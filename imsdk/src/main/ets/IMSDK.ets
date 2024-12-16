import { openim as proto } from "./proto/proto"
import { internal_Init, call } from "./native/NativeSDK"
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
      isBackground: isBackground
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
      description: description,
      longitude: longitude,
      latitude: latitude
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
      data: data,
      extension: extension,
      description: description
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
      text: text,
      quoteMessage: message
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
      text: text,
      quoteMessage: message,
      messageEntities: messageEntityList
    })
    call(handleId, proto.event.FuncRequestEventName.CreateAdvancedQuoteMessage,
      proto.sdk.message.CreateAdvancedQuoteMessageReq.encode(req)
        .finish());
  }

  export function CreateCardMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, card: proto.sdk.shared.ICardElem) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateCardMessageReq.create({
      userID: card.userID,
      nickname: card.nickname,
      faceURL: card.faceURL,
      ex: card.ex
    })
    call(handleId, proto.event.FuncRequestEventName.CreateCardMessage,
      proto.sdk.message.CreateCardMessageReq.encode(req)
        .finish())
  }

  export function CreateImageMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, sourcePath: string,
    bigPath: string | null, snapShotPath: string | null, sourcePicture: proto.sdk.shared.IPictureBaseInfo | null,
    bigPicture: proto.sdk.shared.IPictureBaseInfo | null, snapShotPicture: proto.sdk.shared.IPictureBaseInfo | null) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateImageMessageReq.create({
      sourcePath: sourcePath,
      bigPath: bigPath,
      snapshotPath: snapShotPath,
      sourcePicture: sourcePicture,
      bigPicture: bigPicture,
      snapshotPicture: snapShotPicture
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
      soundPath: soundPath,
      duration: duration
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
      videoSourcePath: videoPath,
      videoType: videoType,
      duration: duration,
      snapshotSourcePath: snapshotPath
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
      fileSourcePath: filePath,
      fileName: fileName
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
      title: title,
      messages: messages,
      summaries: summarys
    })
    call(handleId, proto.event.FuncRequestEventName.CreateMergerMessage,
      proto.sdk.message.CreateMergerMessageReq.encode(req)
        .finish());
  }

  export function CreateFaceMessage(cb: (suc: proto.sdk.shared.IIMMessage) => void, index: number, data: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.CreateFaceMessageReq.create({
      index: index,
      data: data,
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
      message: message
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
    pageNumber: number, showNumber: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.GetConversationListSplitReq.create({
      pagination: proto.sdk.common.RequestPagination.create({
        pageNumber: pageNumber,
        showNumber: showNumber,
      })
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
      sessionType: sessionType,
      sourceID: sourceId,
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
      conversationIDList: conversationIds
    })
    call(handleId, proto.event.FuncRequestEventName.GetMultipleConversation,
      proto.sdk.conversation.GetMultipleConversationReq.encode(req)
        .finish());
  }

  export function HideConversation(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.HideConversationReq.create({
      conversationID: conversationId
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
      conversationID: conversationId,
      draftText: draftText,
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
      sourceID: sourceId,
      sessionType: sessionType,
    })
    call(handleId, proto.event.FuncRequestEventName.GetConversationIDBySessionType,
      proto.sdk.conversation.GetConversationIDBySessionTypeReq.encode(req)
        .finish())
  }

  export function SendMessage(cb: listener.ISendMsg, message: proto.sdk.shared.IIMMessage, recvId: string,
    groupId: string, isOnlineOnly: boolean) {
    let handleId = genHandleId();
    event.RegisterSendMsgCallBack(handleId, cb);
    let req = proto.sdk.message.SendMessageReq.create({
      message: message,
      recvID: recvId,
      groupID: groupId,
      isOnlineOnly: isOnlineOnly,
    })
    call(handleId, proto.event.FuncRequestEventName.SendMessage, proto.sdk.message.SendMessageReq.encode(req)
      .finish())
  }

  export function FindMessageList(cb: (count: number,
    data: proto.sdk.conversation.ISearchByConversationResult[]) => void,
    args: proto.sdk.conversation.IConversationArgs[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.FindMessageListReq.create({
      conversationsArgs: args
    });
    call(handleId, proto.event.FuncRequestEventName.FindMessageList,
      proto.sdk.conversation.FindMessageListReq.encode(req)
        .finish());
  }

  export function GetHistoryMessageList(cb: (messages: proto.sdk.shared.IIMMessage[]) => void, conversationId: string,
    startClientMsgId: string, count: number, isReverse: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.GetHistoryMessageListReq.create({
      conversationID: conversationId,
      startClientMsgID: startClientMsgId,
      count: count,
      isReverse: isReverse,
    })
    call(handleId, proto.event.FuncRequestEventName.GetHistoryMessageList,
      proto.sdk.message.GetHistoryMessageListReq.encode(req)
        .finish())
  }

  export function RevokeMessage(cb: (suc: boolean) => void, conversationId: string, clientMsgId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.RevokeMessageReq.create({
      conversationID: conversationId,
      clientMsgID: clientMsgId
    })
    call(handleId, proto.event.FuncRequestEventName.RevokeMessage, proto.sdk.message.RevokeMessageReq.encode(req)
      .finish())
  }

  export function TypingStatusUpdate(cb: (suc: boolean) => void, recvId: string, msgTip: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.TypingStatusUpdateReq.create({
      recvID: recvId,
      msgTip: msgTip
    })
    call(handleId, proto.event.FuncRequestEventName.TypingStatusUpdate,
      proto.sdk.message.TypingStatusUpdateReq.encode(req)
        .finish())
  }

  export function MarkConversationMessageAsRead(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.MarkConversationMessageAsReadReq.create({
      conversationID: conversationId
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
      conversationID: conversationId,
      clientMsgID: clientMsgId
    })
    call(handleId, proto.event.FuncRequestEventName.DeleteMessageFromLocal,
      proto.sdk.message.DeleteAllMessageFromLocalReq.encode(req)
        .finish())
  }

  export function DeleteMessage(cb: (suc: boolean) => void, conversationId: string, clientMsgId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.message.DeleteMessageReq.create({
      conversationID: conversationId,
      clientMsgID: clientMsgId
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
      conversationID: conversationId
    })
    call(handleId, proto.event.FuncRequestEventName.ClearConversationAndDeleteAllMsg,
      proto.sdk.conversation.ClearConversationAndDeleteAllMsgReq.encode(req)
        .finish())
  }

  export function DeleteConversationAndDeleteAllMsg(cb: (suc: boolean) => void, conversationId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.DeleteConversationAndDeleteAllMsgReq.create({
      conversationID: conversationId
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
      msg: message,
      recvID: recvId,
      sendID: sendId
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
      msg: message,
      groupID: groupId,
      sendID: sendId
    })
    call(handleId, proto.event.FuncRequestEventName.InsertGroupMessageToLocal,
      proto.sdk.message.InsertGroupMessageToLocalReq.encode(req)
        .finish())
  }

  export function SearchLocalMessages(cb: (count: number,
    data: proto.sdk.conversation.ISearchByConversationResult[]) => void,
    req: proto.sdk.conversation.SearchLocalMessagesReq) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SearchLocalMessages,
      proto.sdk.conversation.SearchLocalMessagesReq.encode(req)
        .finish())
  }

  export function SearchConversation(cb: (conversations: proto.sdk.shared.IIMConversation[]) => void,
    searchParam: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.SearchConversationReq.create({
      searchParam: searchParam
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
      conversationID: conversationId,
      clientMsgID: clientMsgId,
      localEx: localEx
    })
    call(handleId, proto.event.FuncRequestEventName.SetMessageLocalEx,
      proto.sdk.conversation.SetMessageLocalExReq.encode(req)
        .finish())
  }

  export function GetUsersInfo(cb: (user: proto.sdk.shared.IIMUser[]) => void, userIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.GetUsersInfoReq.create({
      userIDs: userIds
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
      userIDs: userIds
    })
    call(handleId, proto.event.FuncRequestEventName.SubscribeUsersOnlineStatus,
      proto.sdk.conversation.SubscribeUsersOnlineStatusReq.encode(req)
        .finish());
  }

  export function UnsubscribeUsersOnlineStatus(cb: (suc: boolean) => void, userIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.conversation.UnsubscribeUsersOnlineStatusReq.create({
      userIDs: userIds
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
      userID: userId,
      type: type,
      uuid: uuid,
      value: value,
      ex: ex
    })
    call(handleId, proto.event.FuncRequestEventName.ProcessUserCommandAdd,
      proto.sdk.user.ProcessUserCommandAddReq.encode(req)
        .finish())
  }

  export function ProcessUserCommandDelete(cb: (suc: boolean) => void, userId: string, type: number, uuid: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.user.ProcessUserCommandDeleteReq.create({
      userID: userId,
      type: type,
      uuid: uuid,
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
      userID: userId,
      type: type,
      uuid: uuid,
      value: value,
      ex: ex
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
      filterBlack: filterBlack,
      friendUserIDs: userIdList,
    })
    call(handleId, proto.event.FuncRequestEventName.GetSpecifiedFriends,
      proto.sdk.relation.GetSpecifiedFriendsReq.encode(req)
        .finish());
  }

  export function GetFriends(cb: (friends: proto.sdk.shared.IIMFriend[]) => void, filterBlack: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetFriendsReq.create({
      filterBlack: filterBlack
    })
    call(handleId, proto.event.FuncRequestEventName.GetFriends, proto.sdk.relation.GetFriendsReq.encode(req)
      .finish())
  }

  export function GetFriendsPage(cb: (friends: proto.sdk.shared.IIMFriend[]) => void, pageNumber: number,
    showNumber: number, filterBlack: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetFriendsPageReq.create({
      filterBlack: filterBlack,
      pagination: proto.sdk.common.RequestPagination.create({
        pageNumber: pageNumber,
        showNumber: showNumber,
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
      keyword: keyWord,
      searchUserID: searchUserId,
      searchNickname: searchNickName,
      searchRemark: searchRemark
    })
    call(handleId, proto.event.FuncRequestEventName.SearchFriends, proto.sdk.relation.SearchFriendsReq.encode(req)
      .finish())
  }

  export function UpdateFriend(cb: (suc: boolean) => void, userId: string, pinned: boolean, remark: string,
    ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.UpdateFriendReq.create({
      userID: userId,
      pinned: pinned,
      remark: remark,
      ex: ex,
    })
    call(handleId, proto.event.FuncRequestEventName.UpdateFriend, proto.sdk.relation.UpdateFriendReq.encode(req)
      .finish())
  }

  export function CheckFriend(cb: (info: proto.sdk.relation.CheckFriendInfo[]) => void, userIdList: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.CheckFriendReq.create({
      friendUserIDs: userIdList
    })
    call(handleId, proto.event.FuncRequestEventName.CheckFriend, proto.sdk.relation.CheckFriendReq.encode(req)
      .finish());
  }

  export function AddFriend(cb: (suc: boolean) => void, userId: string, reqMsg: string, ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);

    let req = proto.sdk.relation.AddFriendReq.create({
      userID: userId,
      reqMsg: reqMsg,
      ex: ex,
    })
    call(handleId, proto.event.FuncRequestEventName.AddFriend, proto.sdk.relation.AddFriendReq.encode(req)
      .finish())
  }

  export function DeleteFriend(cb: (suc: boolean) => void, friendUserId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.DeleteFriendReq.create({
      userID: friendUserId
    })
    call(handleId, proto.event.FuncRequestEventName.DeleteFriend, proto.sdk.relation.DeleteFriendReq.encode(req)
      .finish())
  }

  export function GetFriendApplication(cb: (application: proto.sdk.shared.IIMFriendApplication) => void,
    send: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetFriendApplicationReq.create({
      send: send
    })
    call(handleId, proto.event.FuncRequestEventName.GetFriendApplication,
      proto.sdk.relation.GetFriendApplicationReq.encode(req)
        .finish())
  }

  export function HandleFriendRequest(cb: (suc: boolean) => void, userId: string, handleMsg: string,
    status: proto.sdk.common.ApprovalStatus) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.HandleFriendApplicationReq.create({
      userID: userId,
      handleMsg: handleMsg,
      status: status,
    })
    call(handleId, proto.event.FuncRequestEventName.HandleFriendApplication,
      proto.sdk.relation.HandleFriendApplicationReq.encode(req)
        .finish())
  }

  export function AddBlack(cb: (suc: boolean) => void, userId: string, ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.AddBlackReq.create({
      userID: userId,
      ex: ex
    })
    call(handleId, proto.event.FuncRequestEventName.AddBlack, proto.sdk.relation.AddBlackReq.encode(req)
      .finish())
  }

  export function GetBlacks(cb: (black: proto.sdk.shared.IIMBlack[]) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.GetBlacksReq.create({})
    call(handleId, proto.event.FuncRequestEventName.GetBlacks, proto.sdk.relation.GetBlacksReq.encode(req)
      .finish())
  }

  export function DeleteBlack(cb: (suc: boolean) => void, removeUserId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.relation.DeleteBlackReq.create({
      userID: removeUserId
    })
    call(handleId, proto.event.FuncRequestEventName.DeleteBlack, proto.sdk.relation.DeleteBlackReq.encode(req)
      .finish())
  }

  export function CreateGroup(cb: (group: proto.sdk.shared.IIMGroup) => void, group: proto.sdk.shared.IIMGroup,
    adminUserIds: string[], memeberUserIds: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.CreateGroupReq.create({
      memberUserIDs: memeberUserIds,
      adminUserIDs: adminUserIds,
      groupName: group.groupName,
    })
    call(handleId, proto.event.FuncRequestEventName.CreateGroup, proto.sdk.group.CreateGroupReq.encode(req)
      .finish());
  }

  export function JoinGroup(cb: (suc: boolean) => void, groupId: string, reqMsg: string,
    joinSource: proto.sdk.shared.GroupJoinSource, ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.JoinGroupReq.create({
      groupID: groupId,
      reqMsg: reqMsg,
      joinSource: joinSource,
      ex: ex
    })
    call(handleId, proto.event.FuncRequestEventName.JoinGroup, proto.sdk.group.JoinGroupReq.encode(req)
      .finish())
  }

  export function QuitGroup(cb: (suc: boolean) => void, groupId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.QuitGroupReq.create({
      groupID: groupId
    })
    call(handleId, proto.event.FuncRequestEventName.QuitGroup, proto.sdk.group.QuitGroupReq.encode(req)
      .finish())
  }

  export function DismissGroup(cb: (suc: boolean) => void, groupId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.DismissGroupReq.create({
      groupID: groupId
    })
    call(handleId, proto.event.FuncRequestEventName.DismissGroup, proto.sdk.group.DismissGroupReq.encode(req)
      .finish())
  }

  export function ChangeGroupMute(cb: (suc: boolean) => void, groupId: string, isMute: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.ChangeGroupMuteReq.create({
      groupID: groupId,
      mute: isMute,
    })
    call(handleId, proto.event.FuncRequestEventName.ChangeGroupMute, proto.sdk.group.ChangeGroupMuteReq.encode(req)
      .finish())
  }

  export function ChangeGroupMemberMute(cb: (suc: boolean) => void, groupId: string, userId: string,
    mutedSeconds: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.ChangeGroupMemberMuteReq.create({
      groupID: groupId,
      userID: userId,
      mutedSeconds: mutedSeconds
    })
    call(handleId, proto.event.FuncRequestEventName.ChangeGroupMemberMute,
      proto.sdk.group.ChangeGroupMemberMuteReq.encode(req)
        .finish())
  }

  export function SetGroupMemberInfo(cb: (suc: boolean) => void, groupId: string, userId: string, nickName: string,
    faceUrl: string, roleLevel: number, ex: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.SetGroupMemberInfoReq.create({
      groupID: groupId,
      userID: userId,
      faceURL: faceUrl,
      nickname: nickName,
      roleLevel: roleLevel,
      ex: ex
    })
    call(handleId, proto.event.FuncRequestEventName.SetGroupMemberInfo,
      proto.sdk.group.SetGroupMemberInfoReq.encode(req)
        .finish())
  }

  export function GetJoinedGroups(cb: (group: proto.sdk.shared.IIMGroup[]) => void) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetJoinedGroupsReq.create({})
    call(handleId, proto.event.FuncRequestEventName.GetJoinedGroups, proto.sdk.group.GetJoinedGroupsReq.encode(req)
      .finish())
  }

  export function GetJoinedGroupsPage(cb: (group: proto.sdk.shared.IIMGroup[]) => void, pageNumber: number,
    showNumber: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetJoinedGroupsPageReq.create({
      pagination: proto.sdk.common.RequestPagination.create({
        pageNumber: pageNumber,
        showNumber: showNumber,
      })
    })
    call(handleId, proto.event.FuncRequestEventName.GetJoinedGroupsPage,
      proto.sdk.group.GetJoinedGroupsPageReq.encode(req)
        .finish())
  }

  export function GetSpecifiedGroupsInfo(cb: (groups: proto.sdk.shared.IIMGroup[]) => void, groupIdList: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetSpecifiedGroupsInfoReq.create({
      groupIDs: groupIdList
    })
    call(handleId, proto.event.FuncRequestEventName.GetSpecifiedGroupsInfo,
      proto.sdk.group.GetSpecifiedGroupsInfoReq.encode(req)
        .finish());
  }

  export function SearchGroups(cb: (groups: proto.sdk.shared.IIMGroup[]) => void, keyWord: string,
    searchGroupId: boolean, searchGroupName: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.SearchGroupsReq.create({
      keyword: keyWord,
      searchGroupID: searchGroupId,
      searchGroupName: searchGroupName
    })
    call(handleId, proto.event.FuncRequestEventName.SearchGroups, proto.sdk.group.SearchGroupsReq.encode(req)
      .finish())
  }

  export function SetGroupInfo(cb: (suc: boolean) => void, req: proto.sdk.group.ISetGroupInfoReq) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    call(handleId, proto.event.FuncRequestEventName.SetGroupInfo, proto.sdk.group.SetGroupInfoReq.encode(req)
      .finish());
  }

  export function GetGroupMembers(cb: (memebers: proto.sdk.shared.IIMGroupMember) => void, groupId: string,
    filter: proto.sdk.group.GroupMemberFilter, pageNumber: number, showNumber: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetGroupMembersReq.create({
      groupID: groupId,
      filter: filter,
      pagination: proto.sdk.common.RequestPagination.create({
        pageNumber: pageNumber,
        showNumber: showNumber,
      })
    })
    call(handleId, proto.event.FuncRequestEventName.GetGroupMembers, proto.sdk.group.GetGroupMembersReq.encode(req)
      .finish())
  }

  export function GetGroupMemberOwnerAndAdmin(cb: (groupMemebers: proto.sdk.shared.IIMGroupMember[]) => void,
    groupId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetGroupMemberOwnerAndAdminReq.create({
      groupID: groupId
    })
    call(handleId, proto.event.FuncRequestEventName.GetGroupMemberOwnerAndAdmin,
      proto.sdk.group.GetGroupMemberOwnerAndAdminReq.encode(req)
        .finish())
  }

  export function GetGroupMembersByJoinTimeFilter(cb: (groupMemebers: proto.sdk.shared.IIMGroupMember[]) => void,
    groupId: string, joinTimeBegin: number, joinTimeEnd: number, pageNumber: number, showNumber: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetGroupMembersByJoinTimeFilterReq.create({
      groupID: groupId,
      joinTimeBegin: joinTimeBegin,
      joinTimeEnd: joinTimeEnd,
      pagination: proto.sdk.common.RequestPagination.create({
        pageNumber: pageNumber,
        showNumber: showNumber,
      })
    })
    call(handleId, proto.event.FuncRequestEventName.GetGroupMembersByJoinTimeFilter,
      proto.sdk.group.GetGroupMemberOwnerAndAdminReq.encode(req)
        .finish());
  }

  export function GetSpecifiedGroupMembersInfo(cb: (members: proto.sdk.shared.IIMGroupMember[]) => void,
    groupId: string, userIdList: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetSpecifiedGroupMembersInfoReq.create({
      groupID: groupId,
      userIDs: userIdList
    })
    call(handleId, proto.event.FuncRequestEventName.GetSpecifiedGroupMembersInfo,
      proto.sdk.group.GetSpecifiedGroupMembersInfoReq.encode(req)
        .finish());
  }

  export function KickGroupMember(cb: (suc: boolean) => void, groupId: string, reason: string, userIdList: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.KickGroupMemberReq.create({
      groupID: groupId,
      reason: reason,
      kickedUserIDs: userIdList
    })
    call(handleId, proto.event.FuncRequestEventName.KickGroupMember, proto.sdk.group.KickGroupMemberReq.encode(req)
      .finish());
  }

  export function TransferGroupOwner(cb: (suc: boolean) => void, groupId: string, ownerUserId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.TransferGroupOwnerReq.create({
      groupID: groupId,
      ownerUserID: ownerUserId
    })
    call(handleId, proto.event.FuncRequestEventName.TransferGroupOwner,
      proto.sdk.group.TransferGroupOwnerReq.encode(req)
        .finish())
  }

  export function InviteUserToGroup(cb: (suc: boolean) => void, groupId: string, reason: string, userIdList: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.InviteUserToGroupReq.create({
      groupID: groupId,
      reason: reason,
      userIDs: userIdList
    })
    call(handleId, proto.event.FuncRequestEventName.InviteUserToGroup, proto.sdk.group.InviteUserToGroupReq.encode(req)
      .finish());
  }

  export function GetGroupApplication(cb: (applications: proto.sdk.shared.IIMGroupApplication[]) => void,
    sender: boolean) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetGroupApplicationReq.create({
      send: sender
    })
    call(handleId, proto.event.FuncRequestEventName.GetGroupApplication,
      proto.sdk.group.GetGroupApplicationReq.encode(req)
        .finish())
  }

  export function HandleGroupApplication(cb: (suc: boolean) => void, groupId: string, fromUserId: string,
    handleMsg: string, status: proto.sdk.common.ApprovalStatus) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.HandleGroupApplicationReq.create({
      groupID: groupId,
      fromUserID: fromUserId,
      handledMsg: handleMsg,
      status: status,
    })
    call(handleId, proto.event.FuncRequestEventName.HandleGroupApplication,
      proto.sdk.group.HandleGroupApplicationReq.encode(req)
        .finish())
  }

  export function SearchGroupMembers(cb: (member: proto.sdk.shared.IIMGroupMember) => void, groupId: string,
    keyWord: string, searchUserId: boolean, searchNickName: boolean, pageNumber: number, showNumber: number) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.SearchGroupMembersReq.create({
      groupID: groupId,
      keyword: keyWord,
      searchUserID: searchUserId,
      searchMemberNickname: searchNickName,
      pagination: proto.sdk.common.RequestPagination.create({
        pageNumber: pageNumber,
        showNumber: showNumber,
      })
    })
    call(handleId, proto.event.FuncRequestEventName.SearchGroupMembers,
      proto.sdk.group.SearchGroupMembersReq.encode(req)
        .finish())
  }

  export function IsJoinGroup(cb: (suc: boolean) => void, groupId: string) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.IsJoinGroupReq.create({
      groupID: groupId
    })
    call(handleId, proto.event.FuncRequestEventName.IsJoinGroup, proto.sdk.group.IsJoinGroupReq.encode(req)
      .finish())
  }

  export function GetUsersInGroup(cb: (userIds: string[]) => void, groupId: string, userIdList: string[]) {
    let handleId = genHandleId();
    event.RegisterCallBack(handleId, cb);
    let req = proto.sdk.group.GetUsersInGroupReq.create({
      groupID: groupId,
      userIDs: userIdList
    })
    call(handleId, proto.event.FuncRequestEventName.GetUsersInGroup, proto.sdk.group.GetUsersInGroupReq.encode(req)
      .finish());
  }

  export function UploadLogs(cb: listener.IUploadLogs, line: number, ex: string,
    mode: proto.sdk.common.UploadSDKDataMode) {
    let handleId = genHandleId();
    event.RegisterUploadLogsCallBack(handleId, cb);
    let req = proto.sdk.third.UploadSDKDataReq.create({
      line: line,
      ex: ex,
      mode: mode
    })
    call(handleId, proto.event.FuncRequestEventName.UploadLogs, proto.sdk.third.UploadSDKDataReq.encode(req)
      .finish())
  }

  export function UploadFile(cb: listener.IUploadFile, filePath: string, name: string, mimeType: string,
    fileCategory: string) {
    let handleId = genHandleId();
    event.RegisterUploadFileCallBack(handleId, cb);
    let req = proto.sdk.third.UploadFileReq.create({
      filepath: filePath,
      name: name,
      mimeType: mimeType,
      fileCategory: fileCategory
    })
    call(handleId, proto.event.FuncRequestEventName.UploadFile, proto.sdk.third.UploadFileReq.encode(req)
      .finish())
  }

  export function Log(level: proto.sdk.common.LogLevel, file: string, line: number, msg: string, err: string,
    kvs: proto.sdk.third.LogKv[]) {
    let handleId = genHandleId();
    let req = proto.sdk.third.LogReq.create({
      logLevel: level,
      file: file,
      line: line,
      msg: msg,
      err: err,
      kvs: kvs
    })
    call(handleId, proto.event.FuncRequestEventName.Log, proto.sdk.third.LogReq.encode(req)
      .finish());
  }
}





