import {
  IAdvancedMsgListener,
  IBatchMsgListener,
  IConnListener,
  IConversationListener,
  IFriendShipListener,
  IGroupListener,
  IUserListener
} from "./Listener";
import { Message } from "./native/Message";
import logger from "./utils/Logger";


type BaseCallBack<T> = (data: T, errCode: number, errMsg: string) => void;

const baseCallBackMap = new Map<string, BaseCallBack<object>>();


export function registerHandler<T>(operationId: string, callBack: BaseCallBack<T>) {
  baseCallBackMap[operationId] = callBack
}

let connListener: IConnListener | null;
let conversationListener: IConversationListener | null;
let groupListener: IGroupListener | null;
let friendShipListener: IFriendShipListener | null;
let advancedMsgListener: IAdvancedMsgListener | null;
let userListener: IUserListener | null;
let batchMsgListener: IBatchMsgListener | null;

export function setConversationListener(listener: IConversationListener) {
  conversationListener = listener;
}

export function setGroupListener(listener: IGroupListener) {
  groupListener = listener;
}

export function setFriendShipListener(listener: IFriendShipListener) {
  friendShipListener = listener;
}

export function setAdvancedMsgListener(listener: IAdvancedMsgListener) {
  advancedMsgListener = listener;
}

export function setUserListener(listener: IUserListener) {
  userListener = listener;
}

export function setBatchMsgListener(listener: IBatchMsgListener) {
  batchMsgListener = listener;
}


export function dispatchMsg(msgId: number, data: string): void {
  logger.info(`dispatch msg -> ${msgId}->${data}`)
  switch (msgId) {
    case Message.Msg_Connecting:
      break;
    case Message.Msg_ConnectSuccess:
      break;
    case Message.Msg_ConnectFailed:
      break;
    case Message.Msg_KickedOffline:
      break;
    case Message.Msg_UserTokenExpired:
      break;
    case Message.Msg_UserTokenInvalid:
      break;
    case Message.Msg_SyncServerStart:
      break;
    case Message.Msg_SyncServerFinish:
      break;
    case Message.Msg_SyncServerProgress:
      break;
    case Message.Msg_SyncServerFailed:
      break;
    case Message.Msg_NewConversation:
      break;
    case Message.Msg_ConversationChanged:
      break;
    case Message.Msg_TotalUnreadMessageCountChanged:
      break;
    case Message.Msg_ConversationUserInputStatusChanged:
      break;
    case Message.Msg_Advanced_RecvNewMessage:
      break;
    case Message.Msg_Advanced_RecvC2CReadReceipt:
      break;
    case Message.Msg_Advanced_RecvGroupReadReceipt:
      break;
    case Message.Msg_Advanced_NewRecvMessageRevoked:
      break;
    case Message.Msg_Advanced_RecvMessageExtensionsChanged:
      break;
    case Message.Msg_Advanced_RecvMessageExtensionsDeleted:
      break;
    case Message.Msg_Advanced_RecvMessageExtensionsAdded:
      break;
    case Message.Msg_Advanced_RecvOfflineNewMessage:
      break;
    case Message.Msg_Advanced_MsgDeleted:
      break;
    case Message.Msg_Advanced_RecvOnlineOnlyMessage:
      break;
    case Message.Msg_Batch_RecvNewMessages:
      break;
    case Message.Msg_Batch_RecvOfflineNewMessages:
      break;
    case Message.Msg_FriendApplicationAdded:
      break;
    case Message.Msg_FriendApplicationDeleted:
      break;
    case Message.Msg_FriendApplicationAccepted:
      break;
    case Message.Msg_FriendApplicationRejected:
      break;
    case Message.Msg_FriendAdded:
      break;
    case Message.Msg_FriendDeleted:
      break;
    case Message.Msg_FriendInfoChanged:
      break;
    case Message.Msg_BlackAdded:
      break;
    case Message.Msg_BlackDeleted:
      break;
    case Message.Msg_JoinedGroupAdded:
      break;
    case Message.Msg_JoinedGroupDeleted:
      break;
    case Message.Msg_GroupMemberAdded:
      break;
    case Message.Msg_GroupMemberDeleted:
      break;
    case Message.Msg_GroupApplicationAdded:
      break;
    case Message.Msg_GroupApplicationDeleted:
      break;
    case Message.Msg_GroupInfoChanged:
      break;
    case Message.Msg_GroupDismissed:
      break;
    case Message.Msg_GroupMemberInfoChanged:
      break;
    case Message.Msg_GroupApplicationAccepted:
      break;
    case Message.Msg_GroupApplicationRejected:
      break;
    case Message.Msg_RecvCustomBusinessMessage:
      break;
    case Message.Msg_SelfInfoUpdated:
      break;
    case Message.Msg_UserStatusChanged:
      break;
    case Message.Msg_UserCommandAdd:
      break;
    case Message.Msg_UserCommandDelete:
      break;
    case Message.Msg_UserCommandUpdate:
      break;
    case Message.Msg_SendMessage_Error:
      break;
    case Message.Msg_SendMessage_Success:
      break;
    case Message.Msg_SendMessage_Progress:
      break;
    case Message.Msg_ActiveCall:
      break;
    default:
      break;
  }
}