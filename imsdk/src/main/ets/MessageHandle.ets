import {
  AdvancedMessageResult,
  BlackInfo,
  Conversation,
  FindMessageResult,
  FriendApplicationInfo,
  FriendInfo,
  GroupApplicationInfo,
  GroupInfo,
  GroupMember,
  InputStatesChangedData,
  Message,
  MessageReceipt,
  MessageRevoked,
  OnlineStatus,
  PublicUserInfo,
  SearchFriendItem,
  SearchMessageResult,
  UserIDResult,
  UserInfo
} from "./Data";
import {
  IAdvancedMsgListener,
  IBatchMsgListener,
  IConnListener,
  IConversationListener,
  IFriendShipListener,
  IGroupListener,
  IUserListener
} from "./Listener";
import { MessageDef } from "./native/Message";
import logger from "./utils/Logger";
import { JSON } from "@kit.ArkTS";
import { DataTypeDef } from "./native/DATAType";
import { parseJson } from "./utils/Json";

export interface IMsgSendCallBack {
  onError(code: number, errMsg: string): void

  onSuccess(msg: Message): void

  onProgress(progress: number): void
}

interface Error {
  errCode: number;
  errMsg: string;
  operationId: string;
}

interface Success {
  operationId: string;
  dataType: number;
  data: string;
}

interface ActiveCallResult {
  operationId: string;
  errCode: number;
  errMsg: string;
  dataType: number;
  data: string;
}

interface Progress {
  operationId: string;
  progress: number;
}

interface MsgIDAndList {
  msgId: string;
  list: string;
}


type BaseCallBack<T> = (data: T, errCode: number, errMsg: string) => void;

const activeCallCallBackMap = new Map<string, BaseCallBack<object | number | boolean | string | undefined>>();
const msgCallBackMap = new Map<string, IMsgSendCallBack>();

export function registerHandler<T>(operationId: string, callBack: BaseCallBack<T>) {
  activeCallCallBackMap[operationId] = callBack
}

export function registerSendMsgHandler(operationId: string, callBack: IMsgSendCallBack) {
  msgCallBackMap[operationId] = callBack
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

export function dispatchMsg(id: MessageDef, msg: string) {
  logger.info(`dispatch msg -> ${id}->${msg}`)
  switch (id) {
    case MessageDef.Connecting:
      connListener?.onConnecting();
      break;
    case MessageDef.ConnectSuccess:
      connListener?.onConnectSuccess();
      break;
    case MessageDef.ConnectFailed: {
      const err = JSON.parse(msg) as Error;
      connListener?.onConnectFailed(err.errCode, err.errMsg);
      break;
    }
    case MessageDef.KickedOffline:
      connListener?.onKickedOffline();
      break;
    case MessageDef.UserTokenExpired:
      connListener?.onUserTokenExpired();
      break;
    case MessageDef.UserTokenInvalid: {
      const err = JSON.parse(msg) as Error;
      connListener?.onUserTokenInvalid(err.errMsg);
      break;
    }
    case MessageDef.SyncServerStart:
      conversationListener?.onSyncServerStart();
      break;
    case MessageDef.SyncServerFinish:
      conversationListener?.onSyncServerFinish();
      break;
    case MessageDef.SyncServerProgress:
      const progress = JSON.parse(msg) as Progress;
      conversationListener?.onSyncServerProgress(progress.progress);
      break;
    case MessageDef.SyncServerFailed:
      conversationListener?.onSyncServerFailed();
      break;
    case MessageDef.NewConversation:
      const conversation = JSON.parse(msg) as Conversation[];
      conversationListener?.onNewConversation(conversation);
      break;
    case MessageDef.ConversationChanged:
      const conversationList = JSON.parse(msg) as Conversation[];
      conversationListener?.onConversationChanged(conversationList);
      break;
    case MessageDef.TotalUnreadMessageCountChanged:
      const count = parseInt(msg, 10);
      if (!isNaN(count)) {
        conversationListener?.onTotalUnreadMessageCountChanged(count);
      }
      break;
    case MessageDef.ConversationUserInputStatusChanged:
      const inputStatus = JSON.parse(msg) as InputStatesChangedData;
      conversationListener?.onConversationUserInputStatusChanged(inputStatus);
      break;
    case MessageDef.Advanced_RecvNewMessage:
      const newMsg = JSON.parse(msg) as Message;
      advancedMsgListener?.onRecvNewMessage(newMsg);
      break;
    case MessageDef.Advanced_RecvC2CReadReceipt:
      const c2cReceipt = JSON.parse(msg) as MessageReceipt[];
      advancedMsgListener?.onRecvC2CReadReceipt(c2cReceipt);
      break;
    case MessageDef.Advanced_RecvGroupReadReceipt:
      const groupReceipt = JSON.parse(msg) as MessageReceipt[];
      advancedMsgListener?.onRecvGroupReadReceipt(groupReceipt);
      break;
    case MessageDef.Advanced_NewRecvMessageRevoked:
      const revokedMsg = JSON.parse(msg) as MessageRevoked;
      advancedMsgListener?.onNewRecvMessageRevoked(revokedMsg);
      break;
    case MessageDef.Advanced_RecvMessageExtensionsChanged: {
      const res = JSON.parse(msg) as MsgIDAndList;
      advancedMsgListener?.onRecvMessageExtensionsChanged(res.msgId, res.list);
      break;
    }
    case MessageDef.Advanced_RecvMessageExtensionsDeleted: {
      const res = JSON.parse(msg) as MsgIDAndList;
      advancedMsgListener?.onRecvMessageExtensionsDeleted(res.msgId, res.list);
      break;
    }
    case MessageDef.Advanced_RecvMessageExtensionsAdded: {
      const res = JSON.parse(msg) as MsgIDAndList;
      advancedMsgListener?.onRecvMessageExtensionsAdded(res.msgId, res.list);
      break;
    }
    case MessageDef.Advanced_RecvOfflineNewMessage:
      const offlineNewMsg = JSON.parse(msg) as Message;
      advancedMsgListener?.onRecvOfflineNewMessage(offlineNewMsg);
      break;
    case MessageDef.Advanced_MsgDeleted:
      const deletedMsg = JSON.parse(msg) as Message;
      advancedMsgListener?.onMsgDeleted(deletedMsg);
      break;
    case MessageDef.Advanced_RecvOnlineOnlyMessage:
      const onlineOnlyMsg = JSON.parse(msg) as Message;
      advancedMsgListener?.onRecvOnlineOnlyMessage(onlineOnlyMsg);
      break;
    case MessageDef.Batch_RecvNewMessages:
      const batchNewMsgs = JSON.parse(msg) as Message[];
      batchMsgListener?.onRecvNewMessages(batchNewMsgs);
      break;
    case MessageDef.Batch_RecvOfflineNewMessages:
      const batchOfflineMsgs = JSON.parse(msg) as Message[];
      batchMsgListener?.onRecvOfflineNewMessages(batchOfflineMsgs);
      break;
    case MessageDef.FriendApplicationAdded:
      const friendAppAdded = JSON.parse(msg) as FriendApplicationInfo;
      friendShipListener?.onFriendApplicationAdded(friendAppAdded);
      break;
    case MessageDef.FriendApplicationDeleted:
      const friendAppDeleted = JSON.parse(msg) as FriendApplicationInfo;
      friendShipListener?.onFriendApplicationDeleted(friendAppDeleted);
      break;
    case MessageDef.FriendApplicationAccepted:
      const friendAppAccepted = JSON.parse(msg) as FriendApplicationInfo;
      friendShipListener?.onFriendApplicationAccepted(friendAppAccepted);
      break;
    case MessageDef.FriendApplicationRejected:
      const friendAppRejected = JSON.parse(msg) as FriendApplicationInfo;
      friendShipListener?.onFriendApplicationRejected(friendAppRejected);
      break;
    case MessageDef.FriendAdded:
      const friendAdded = JSON.parse(msg) as FriendInfo;
      friendShipListener?.onFriendAdded(friendAdded);
      break;
    case MessageDef.FriendDeleted:
      const friendDeleted = JSON.parse(msg) as FriendInfo;
      friendShipListener?.onFriendDeleted(friendDeleted);
      break;
    case MessageDef.FriendInfoChanged:
      const friendInfoChanged = JSON.parse(msg) as FriendInfo;
      friendShipListener?.onFriendInfoChanged(friendInfoChanged);
      break;
    case MessageDef.BlackAdded:
      const blackAdded = JSON.parse(msg) as BlackInfo;
      friendShipListener?.onBlackAdded(blackAdded);
      break;
    case MessageDef.BlackDeleted:
      const blackDeleted = JSON.parse(msg) as BlackInfo;
      friendShipListener?.onBlackDeleted(blackDeleted);
      break;
    case MessageDef.JoinedGroupAdded:
      const joinedGroupAdded = JSON.parse(msg) as GroupInfo;
      groupListener?.onJoinedGroupAdded(joinedGroupAdded);
      break;
    case MessageDef.JoinedGroupDeleted:
      const joinedGroupDeleted = JSON.parse(msg) as GroupInfo;
      groupListener?.onJoinedGroupDeleted(joinedGroupDeleted);
      break;
    case MessageDef.GroupMemberAdded:
      const groupMemberAdded = JSON.parse(msg) as GroupMember;
      groupListener?.onGroupMemberAdded(groupMemberAdded);
      break;
    case MessageDef.GroupMemberDeleted:
      const groupMemberDeleted = JSON.parse(msg) as GroupMember;
      groupListener?.onGroupMemberDeleted(groupMemberDeleted);
      break;
    case MessageDef.GroupApplicationAdded:
      const groupAppAdded = JSON.parse(msg) as GroupApplicationInfo;
      groupListener?.onGroupApplicationAdded(groupAppAdded);
      break;
    case MessageDef.GroupApplicationDeleted:
      const groupAppDeleted = JSON.parse(msg) as GroupApplicationInfo;
      groupListener?.onGroupApplicationDeleted(groupAppDeleted);
      break;
    case MessageDef.GroupInfoChanged:
      const groupInfoChanged = JSON.parse(msg) as GroupInfo;
      groupListener?.onGroupInfoChanged(groupInfoChanged);
      break;
    case MessageDef.GroupDismissed:
      const groupDismissed = JSON.parse(msg) as GroupInfo;
      groupListener?.onGroupDismissed(groupDismissed);
      break;
    case MessageDef.GroupMemberInfoChanged:
      const groupMemberInfoChanged = JSON.parse(msg) as GroupMember;
      groupListener?.onGroupMemberInfoChanged(groupMemberInfoChanged);
      break;
    case MessageDef.GroupApplicationAccepted:
      const groupAppAccepted = JSON.parse(msg) as GroupApplicationInfo;
      groupListener?.onGroupApplicationAccepted(groupAppAccepted);
      break;
    case MessageDef.GroupApplicationRejected:
      const groupAppRejected = JSON.parse(msg) as GroupApplicationInfo;
      groupListener?.onGroupApplicationRejected(groupAppRejected);
      break;
    case MessageDef.RecvCustomBusinessMessage:
      break;
    case MessageDef.SelfInfoUpdated:
      const selfInfoUpdated = JSON.parse(msg) as UserInfo;
      userListener?.onSelfInfoUpdated(selfInfoUpdated);
      break;
    case MessageDef.UserStatusChanged:
      const userStatusChanged = JSON.parse(msg) as OnlineStatus;
      userListener?.onUserStatusChanged(userStatusChanged);
      break;
    case MessageDef.UserCommandAdd:
      userListener?.onUserCommandAdd(msg);
      break;
    case MessageDef.UserCommandDelete:
      userListener?.onUserCommandDelete(msg);
      break;
    case MessageDef.UserCommandUpdate:
      userListener?.onUserCommandUpdate(msg);
      break;
    case MessageDef.SendMessage_Error: {
      const res = JSON.parse(msg) as Error;
      if (msgCallBackMap.has(res.operationId)) {
        msgCallBackMap.get(res.operationId)?.onError(res.errCode, res.errMsg)
        msgCallBackMap.delete(res.operationId)
      }
      break;
    }
    case MessageDef.SendMessage_Success: {
      const res = JSON.parse(msg) as Success;
      if (msgCallBackMap.has(res.operationId)) {
        msgCallBackMap.get(res.operationId)?.onSuccess((JSON.parse(res.data) as Message))
        msgCallBackMap.delete(res.operationId)
      }
      break;
    }
    case MessageDef.SendMessage_Progress: {
      const res = JSON.parse(msg) as Progress;
      if (msgCallBackMap.has(res.operationId)) {
        msgCallBackMap.get(res.operationId)?.onProgress(res.progress)
      }
      break;
    }
    case MessageDef.ActiveCall: {
      const res = JSON.parse(msg) as ActiveCallResult;
      if (activeCallCallBackMap.has(res.operationId)) {
        const callBack = activeCallCallBackMap.get(res.operationId);
        if (callBack != null) {
          callBack(convertDataType(res.dataType, res.data), res.errCode, res.errMsg)
        }
        activeCallCallBackMap.delete(res.operationId)
      }
      break;
    }
  }
}

function convertDataType(type: number, msg: string): object | boolean | string | number | undefined {
  switch (type) {
    case DataTypeDef.Empty:
      return "";
    case DataTypeDef.Int:
      return parseJson<number>(msg);
    case DataTypeDef.Bool:
      return parseJson<boolean>(msg);
    case DataTypeDef.StringArray:
      return parseJson<string[]>(msg);
    case DataTypeDef.Conversation:
      return parseJson<Conversation>(msg);
    case DataTypeDef.Conversation_List:
      return parseJson<Conversation[]>(msg);
    case DataTypeDef.FindMessageResult:
      return parseJson<FindMessageResult>(msg);
    case DataTypeDef.AdvancedHistoryMessageResult:
      return parseJson<AdvancedMessageResult>(msg);
    case DataTypeDef.Message:
      return parseJson<Message>(msg);
    case DataTypeDef.SearchMessagesResult:
      return parseJson<SearchMessageResult>(msg);
    case DataTypeDef.UserInfo:
      return parseJson<UserInfo>(msg);
    case DataTypeDef.UserInfo_List:
      return parseJson<UserInfo[]>(msg);
    case DataTypeDef.PublicUserInfo:
      return parseJson<PublicUserInfo>(msg);
    case DataTypeDef.PublicUserInfo_List:
      return parseJson<PublicUserInfo[]>(msg);
    case DataTypeDef.OnlineStatus:
      return parseJson<OnlineStatus>(msg);
    case DataTypeDef.OnlineStatus_List:
      return parseJson<OnlineStatus[]>(msg);
    case DataTypeDef.SearchFriendItem:
      return parseJson<SearchFriendItem>(msg);
    case DataTypeDef.SearchFriendItem_List:
      return parseJson<SearchFriendItem[]>(msg);
    case DataTypeDef.UserIDResult:
      return parseJson<UserIDResult>(msg);
    case DataTypeDef.UserIDResult_List:
      return parseJson<UserIDResult[]>(msg);
    case DataTypeDef.FriendInfo:
      return parseJson<FriendInfo>(msg);
    case DataTypeDef.FriendInfo_List:
      return parseJson<FriendInfo[]>(msg);
    case DataTypeDef.FriendApplicationInfo:
      return parseJson<FriendApplicationInfo>(msg);
    case DataTypeDef.FriendApplicationInfo_List:
      return parseJson<FriendApplicationInfo[]>(msg);
    case DataTypeDef.BlackInfo:
      return parseJson<BlackInfo>(msg);
    case DataTypeDef.BlackInfo_List:
      return parseJson<BlackInfo[]>(msg);
    case DataTypeDef.GroupInfo:
      return parseJson<GroupInfo>(msg);
    case DataTypeDef.GroupInfo_List:
      return parseJson<GroupInfo[]>(msg);
    case DataTypeDef.GroupMember:
      return parseJson<GroupMember>(msg);
    case DataTypeDef.GroupMember_List:
      return parseJson<GroupMember[]>(msg);
    case DataTypeDef.GroupApplicationInfo:
      return parseJson<GroupApplicationInfo>(msg);
    case DataTypeDef.GroupApplicationInfo_List:
      return parseJson<GroupApplicationInfo[]>(msg);
  }
  return undefined
}