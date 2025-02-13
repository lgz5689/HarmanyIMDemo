import { openim as proto } from "./proto/proto"
import { listener } from "./Listener"
import Long from "long";

export namespace event {

  export type ErrCallBack = (errCode: number, errMsg: string) => void;

  let errCallBack: ErrCallBack | null = null;

  let connListener: listener.ConnListener | null = null;
  let userListener: listener.UserListener | null = null;
  let conversationListener: listener.ConversationListener | null = null;
  let friendShipListener: listener.FriendShipListener | null = null;
  let groupListener: listener.GroupListener | null = null;
  let messageListener: listener.MessageListener | null = null;

  let callBackDic = new Map<number, Function>();
  let sendMsgCallBackDic = new Map<number, listener.ISendMsg>();
  let uploadFileCallBackDic = new Map<number, listener.IUploadFile>();
  let uploadLogsCallBackDic = new Map<number, listener.IUploadLogs>();

  export function SetErrCallBack(callBack: ErrCallBack) {
    errCallBack = callBack
  }

  export function SetConnListener(conn: listener.ConnListener) {
    connListener = conn
  }

  export function SetUserListener(conn: listener.UserListener) {
    userListener = conn
  }

  export function SetConversationListener(conn: listener.ConversationListener) {
    conversationListener = conn
  }

  export function SetFriendShipListener(conn: listener.FriendShipListener) {
    friendShipListener = conn
  }

  export function SetGroupListener(conn: listener.GroupListener) {
    groupListener = conn
  }

  export function SetMessageListener(conn: listener.MessageListener) {
    messageListener = conn
  }

  export function RegisterCallBack(key: number, callBack: Function) {
    callBackDic.set(key, callBack)
  }

  export function RegisterSendMsgCallBack(key: number, callBack: listener.ISendMsg) {
    sendMsgCallBackDic.set(key, callBack)
  }

  export function RegisterUploadFileCallBack(key: number, callBack: listener.IUploadFile) {
    uploadFileCallBackDic.set(key, callBack)
  }

  export function RegisterUploadLogsCallBack(key: number, callBack: listener.IUploadLogs) {
    uploadLogsCallBackDic.set(key, callBack)
  }

  export function DispatchEvent(result: proto.ffi.FfiResult) {
    let errCode = result.errCode;
    let errMsg = result.errMsg;
    let handleId = result.handleID instanceof Long ? result.handleID.toNumber() : result.handleID;
    let eventName = result.funcName;
    let data = result.data;
    let suc = errCode == 0;
    let callBack = callBackDic.get(handleId)
    console.log("DispatchEvent: handlerId = ", handleId, proto.event.FuncRequestEventName[eventName])

    switch (eventName) {
      case proto.event.FuncRequestEventName.None:
        break;
      case proto.event.FuncRequestEventName.InitSDK: {
        let resp = proto.init.InitSDKResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.Login: {
        let resp = proto.init.LoginResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.Logout: {
        let resp = proto.init.LogoutResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetAppBackgroundStatus: {
        let resp = proto.init.SetAppBackgroundStatusResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.NetworkStatusChanged: {
        let resp = proto.init.NetworkStatusChangedResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetLoginStatus: {
        let resp = proto.init.GetLoginStatusResp.decode(data);
        callBack?.(resp.status);
      }
        break;

      case proto.event.FuncRequestEventName.Version: {
        let resp = proto.init.VersionResp.decode(data);
        callBack?.(resp.version);
      }
        break;

      case proto.event.FuncRequestEventName.SendMessage: {
        let msgCallBack = sendMsgCallBackDic.get(handleId)
        if (msgCallBack != undefined) {
          let resp = proto.sdk.message.SendMessageResp.decode(data);
          if (suc) {
            msgCallBack.onSuccess(resp.message);
          } else {
            msgCallBack.onError(errCode, errMsg);
          }
          sendMsgCallBackDic.delete(handleId);
        }
      }
        break;

      case proto.event.FuncRequestEventName.UploadSDKData: {
        let uploadLogCallBack = uploadLogsCallBackDic.get(handleId)
        if (uploadLogCallBack != undefined) {
          let resp = proto.sdk.third.UploadSDKDataResp.decode(data);
          if (suc) {
            uploadLogCallBack.onSuccess();
          } else {
            uploadLogCallBack.onError(errCode, errMsg);
          }
          uploadLogsCallBackDic.delete(handleId);
        }
      }
        break;

      case proto.event.FuncRequestEventName.UploadFile: {
        let uploadFileCallBack = uploadFileCallBackDic.get(handleId)
        if (uploadFileCallBack != undefined) {
          let resp = proto.sdk.third.UploadFileResp.decode(data);
          if (suc) {
            uploadFileCallBack.onSuccess(resp.url);
          } else {
            uploadFileCallBack.onError(errCode, errMsg);
          }
          uploadFileCallBackDic.delete(handleId);
        }
      }
        break;

      case proto.event.FuncRequestEventName.Log:
        break;

      case proto.event.FuncRequestEventName.UpdateFcmToken:
        break;

      case proto.event.FuncRequestEventName.SetAppBadge:
        break;

      case proto.event.FuncRequestEventName.EventOnSendMsgProgress: {
        let msgCallBack = sendMsgCallBackDic.get(handleId)
        if (msgCallBack != undefined) {
          let resp = proto.event.EventOnSendMsgProgressData.decode(data);
          msgCallBack.onProgress(resp.progress);
        }
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUploadFileProgress: {
        let uploadFileCallBack = uploadFileCallBackDic.get(handleId)
        if (uploadFileCallBack != undefined) {
          let resp = proto.event.EventOnUploadFileProgressData.decode(data);
          uploadFileCallBack.onProgress(resp.progress);
        }
      }

        break;

      case proto.event.FuncRequestEventName.EventOnUploadSDKDataProgress: {
        let uploadLogCallBack = uploadLogsCallBackDic.get(handleId)
        if (uploadLogCallBack != undefined) {
          let resp = proto.event.EventOnUploadSDKDataProgressData.decode(data);
          uploadLogCallBack.onProgress(resp.progress);
        }
      }
        break;

      case proto.event.FuncRequestEventName.EventOnConnecting: {
        let resp = proto.event.EventOnConnectingData.decode(data);
        connListener?.onConnecting();
      }
        break;

      case proto.event.FuncRequestEventName.EventOnConnectSuccess: {
        let resp = proto.event.EventOnConnectSuccessData.decode(data);
        connListener?.onConnectSuccess();
      }
        break;

      case proto.event.FuncRequestEventName.EventOnConnectFailed: {
        let resp = proto.event.EventOnConnectFailedData.decode(data);
        connListener?.onConnectFailed(resp.errCode, resp.errMsg);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnKickedOffline: {
        let resp = proto.event.EventOnKickedOfflineData.decode(data);
        connListener?.onKickedOffline();
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUserTokenExpired: {
        let resp = proto.event.EventOnUserTokenExpiredData.decode(data);
        connListener?.onUserTokenExpired();
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUserTokenInvalid: {
        let resp = proto.event.EventOnUserTokenInvalidData.decode(data);
        connListener?.onUserTokenInvalid(resp.errMsg);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnSyncServerStart: {
        let resp = proto.event.EventOnSyncServerStartData.decode(data);
        conversationListener?.onSyncServerStart(resp.reinstalled);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnSyncServerFinish: {
        let resp = proto.event.EventOnSyncServerFinishData.decode(data);
        conversationListener?.onSyncServerFinish(resp.reinstalled);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnSyncServerFailed: {
        let resp = proto.event.EventOnSyncServerFailedData.decode(data);
        conversationListener?.onSyncServerFailed(resp.reinstalled);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnSyncServerProgress: {
        let resp = proto.event.EventOnSyncServerProgressData.decode(data);
        conversationListener?.onSyncServerProgress(resp.progress);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnNewConversation: {
        let resp = proto.event.EventOnNewConversationData.decode(data);
        conversationListener?.onNewConversation(resp.conversationList)
      }
        break;

      case proto.event.FuncRequestEventName.EventOnConversationChanged: {
        let resp = proto.event.EventOnConversationChangedData.decode(data);
        conversationListener?.onConversationChanged(resp.conversationList)
      }
        break;

      case proto.event.FuncRequestEventName.EventOnTotalUnreadMessageCountChanged: {
        let resp = proto.event.EventOnTotalUnreadMessageCountChangedData.decode(data);
        conversationListener?.onTotalUnreadMessageCountChanged(resp.totalUnreadCount);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnConversationUserInputStatusChanged: {
        let resp = proto.event.EventOnConversationUserInputStatusChangedData.decode(data);
        conversationListener?.onConversationUserInputStatusChanged(resp.conversationID, resp.userID, resp.platforms);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnRecvNewMessage: {
        let resp = proto.event.EventOnRecvNewMessageData.decode(data);
        messageListener?.onRecvNewMessage(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnRecvC2CReadReceipt: {
        let resp = proto.event.EventOnRecvC2CReadReceiptData.decode(data);
        messageListener?.onRecvC2CReadReceipt(resp.msgReceiptList)
      }
        break;

      case proto.event.FuncRequestEventName.EventOnNewRecvMessageRevoked: {
        let resp = proto.event.EventOnNewRecvMessageRevokedData.decode(data);
        messageListener?.onNewRecvMessageRevoked(resp.revoked);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnRecvOfflineNewMessage: {
        let resp = proto.event.EventOnRecvOfflineNewMessageData.decode(data);
        messageListener?.onRecvOfflineNewMessage(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnMessageDeleted: {
        let resp = proto.event.EventOnMessageDeletedData.decode(data);
        messageListener?.onMessageDeleted(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnRecvOnlineOnlyMessage: {
        let resp = proto.event.EventOnRecvOnlineOnlyMessageData.decode(data);
        messageListener?.onRecvOnlineOnlyMessage(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnMessageEdited: {
        let resp = proto.event.EventOnMessageEditedData.decode(data);
        messageListener?.onMessageEdited(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendApplicationAdded: {
        let resp = proto.event.EventOnFriendApplicationAddedData.decode(data);
        friendShipListener?.onFriendApplicationAdded(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendApplicationDeleted: {
        let resp = proto.event.EventOnFriendApplicationDeletedData.decode(data);
        friendShipListener?.onFriendApplicationDeleted(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendApplicationAccepted: {
        let resp = proto.event.EventOnFriendApplicationAcceptedData.decode(data);
        friendShipListener?.onFriendApplicationAccepted(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendApplicationRejected: {
        let resp = proto.event.EventOnFriendApplicationRejectedData.decode(data);
        friendShipListener?.onFriendApplicationRejected(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendAdded: {
        let resp = proto.event.EventOnFriendAddedData.decode(data);
        friendShipListener?.onFriendAdded(resp.friend);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendDeleted: {
        let resp = proto.event.EventOnFriendDeletedData.decode(data);
        friendShipListener?.onFriendDeleted(resp.friend);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnFriendInfoChanged: {
        let resp = proto.event.EventOnFriendInfoChangedData.decode(data);
        friendShipListener?.onFriendInfoChanged(resp.friend);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnBlackAdded: {
        let resp = proto.event.EventOnBlackAddedData.decode(data);
        friendShipListener?.onBlackAdded(resp.black);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnBlackDeleted: {
        let resp = proto.event.EventOnBlackDeletedData.decode(data);
        friendShipListener?.onBlackDeleted(resp.black);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnJoinedGroupAdded: {
        let resp = proto.event.EventOnJoinedGroupAddedData.decode(data);
        groupListener?.onJoinedGroupAdded(resp.group);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnJoinedGroupDeleted: {
        let resp = proto.event.EventOnJoinedGroupDeletedData.decode(data);
        groupListener?.onJoinedGroupDeleted(resp.group);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupMemberAdded: {
        let resp = proto.event.EventOnGroupMemberAddedData.decode(data);
        groupListener?.onGroupMemberAdded(resp.member);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupMemberDeleted: {
        let resp = proto.event.EventOnGroupMemberDeletedData.decode(data);
        groupListener?.onGroupMemberDeleted(resp.member);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupApplicationAdded: {
        let resp = proto.event.EventOnGroupApplicationAddedData.decode(data);
        groupListener?.onGroupApplicationAdded(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupApplicationDeleted: {
        let resp = proto.event.EventOnGroupApplicationDeletedData.decode(data);
        groupListener?.onGroupApplicationDeleted(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupInfoChanged: {
        let resp = proto.event.EventOnGroupInfoChangedData.decode(data);
        groupListener?.onGroupInfoChanged(resp.group);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupDismissed: {
        let resp = proto.event.EventOnGroupDismissedData.decode(data);
        groupListener?.onGroupDismissed(resp.group);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupMemberInfoChanged: {
        let resp = proto.event.EventOnGroupMemberInfoChangedData.decode(data);
        groupListener?.onGroupMemberInfoChanged(resp.member);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupApplicationAccepted: {
        let resp = proto.event.EventOnGroupApplicationAcceptedData.decode(data);
        groupListener?.onGroupApplicationAccepted(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnGroupApplicationRejected: {
        let resp = proto.event.EventOnGroupApplicationRejectedData.decode(data);
        groupListener?.onGroupApplicationRejected(resp.application);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnRecvCustomBusinessMessage: {
        // let resp = proto.event.EventOnRecvCustomBusinessMessageData.decode(data);
        // customBusinessListener?.onRecvCustomBusinessMessage(resp.BusinessMessage);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnSelfInfoUpdated: {
        let resp = proto.event.EventOnSelfInfoUpdatedData.decode(data);
        userListener?.onSelfInfoUpdated(resp.user);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUserOnlineStatusChanged: {
        let resp = proto.event.EventOnUserOnlineStatusChangedData.decode(data);
        userListener?.onUserOnlineStatusChanged(resp.userID, resp.platforms)
      }
        break;

      case proto.event.FuncRequestEventName.CreateGroup: {
        let resp = proto.sdk.group.CreateGroupResp.decode(data);
        callBack?.(resp.groupInfo);
      }
        break;

      case proto.event.FuncRequestEventName.JoinGroup: {
        let resp = proto.sdk.group.JoinGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.QuitGroup: {
        let resp = proto.sdk.group.QuitGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DismissGroup: {
        let resp = proto.sdk.group.DismissGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ChangeGroupMute: {
        let resp = proto.sdk.group.ChangeGroupMuteResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ChangeGroupMemberMute: {
        let resp = proto.sdk.group.ChangeGroupMemberMuteResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.TransferGroupOwner: {
        let resp = proto.sdk.group.TransferGroupOwnerResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.KickGroupMember: {
        let resp = proto.sdk.group.KickGroupMemberResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetGroupInfo: {
        let resp = proto.sdk.group.SetGroupInfoResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetGroupMemberInfo: {
        let resp = proto.sdk.group.SetGroupMemberInfoResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetJoinedGroups: {
        let resp = proto.sdk.group.GetJoinedGroupsResp.decode(data);
        callBack?.(resp.groups);
      }
        break;

      case proto.event.FuncRequestEventName.GetJoinedGroupsPage: {
        let resp = proto.sdk.group.GetJoinedGroupsPageResp.decode(data);
        callBack?.(resp.groups);
      }
        break;

      case proto.event.FuncRequestEventName.GetSpecifiedGroupsInfo: {
        let resp = proto.sdk.group.GetSpecifiedGroupsInfoResp.decode(data);
        callBack?.(resp.groups);
      }
        break;

      case proto.event.FuncRequestEventName.SearchGroups: {
        let resp = proto.sdk.group.SearchGroupsResp.decode(data);
        callBack?.(resp.groups);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupMemberOwnerAndAdmin: {
        let resp = proto.sdk.group.GetGroupMemberOwnerAndAdminResp.decode(data);
        callBack?.(resp.members);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupMembersByJoinTimeFilter: {
        let resp = proto.sdk.group.GetGroupMembersByJoinTimeFilterResp.decode(data);
        callBack?.(resp.members);
      }
        break;

      case proto.event.FuncRequestEventName.GetSpecifiedGroupMembersInfo: {
        let resp = proto.sdk.group.GetSpecifiedGroupMembersInfoResp.decode(data);
        callBack?.(resp.members);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupMembers: {
        let resp = proto.sdk.group.GetGroupMembersResp.decode(data);
        callBack?.(resp.members);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupApplication: {
        let resp = proto.sdk.group.GetGroupApplicationResp.decode(data);
        callBack?.(resp.applications);
      }
        break;

      case proto.event.FuncRequestEventName.SearchGroupMembers: {
        let resp = proto.sdk.group.SearchGroupMembersResp.decode(data);
        callBack?.(resp.members);
      }
        break;

      case proto.event.FuncRequestEventName.IsJoinGroup: {
        let resp = proto.sdk.group.IsJoinGroupResp.decode(data);
        callBack?.(resp.joined);
      }
        break;

      case proto.event.FuncRequestEventName.GetUsersInGroup: {
        let resp = proto.sdk.group.GetUsersInGroupResp.decode(data);
        callBack?.(resp.userIDs);
      }
        break;

      case proto.event.FuncRequestEventName.InviteUserToGroup: {
        let resp = proto.sdk.group.InviteUserToGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.HandleGroupApplication: {
        let resp = proto.sdk.group.HandleGroupApplicationResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetSpecifiedFriends: {
        let resp = proto.sdk.relation.GetSpecifiedFriendsResp.decode(data);
        callBack?.(resp.friends);
      }
        break;

      case proto.event.FuncRequestEventName.AddFriend: {
        let resp = proto.sdk.relation.AddFriendResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetFriendApplication: {
        let resp = proto.sdk.relation.GetFriendApplicationResp.decode(data);
        callBack?.(resp.applications);
      }
        break;

      case proto.event.FuncRequestEventName.HandleFriendApplication: {
        let resp = proto.sdk.relation.HandleFriendApplicationResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.CheckFriend: {
        let resp = proto.sdk.relation.CheckFriendResp.decode(data);
        callBack?.(resp.result);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteFriend: {
        let resp = proto.sdk.relation.DeleteFriendResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetFriends: {
        let resp = proto.sdk.relation.GetFriendsResp.decode(data);
        callBack?.(resp.friends);
      }
        break;

      case proto.event.FuncRequestEventName.GetFriendsPage: {
        let resp = proto.sdk.relation.GetFriendsPageResp.decode(data);
        callBack?.(resp.friends);
      }
        break;

      case proto.event.FuncRequestEventName.SearchFriends: {
        let resp = proto.sdk.relation.SearchFriendsResp.decode(data);
        callBack?.(resp.friends);
      }
        break;

      case proto.event.FuncRequestEventName.AddBlack: {
        let resp = proto.sdk.relation.AddBlackResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteBlack: {
        let resp = proto.sdk.relation.DeleteBlackResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetBlacks: {
        let resp = proto.sdk.relation.GetBlacksResp.decode(data);
        callBack?.(resp.blacks);
      }
        break;

      case proto.event.FuncRequestEventName.UpdateFriend: {
        let resp = proto.sdk.relation.UpdateFriendResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetAllConversationList: {
        let resp = proto.sdk.conversation.GetAllConversationListResp.decode(data);
        callBack?.(resp.conversationList);
      }
        break;

      case proto.event.FuncRequestEventName.GetConversationListSplit: {
        let resp = proto.sdk.conversation.GetConversationListSplitResp.decode(data);
        callBack?.(resp.conversationList);
      }
        break;

      case proto.event.FuncRequestEventName.HideConversation: {
        let resp = proto.sdk.conversation.HideConversationResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetAtAllTag: {
        let resp = proto.sdk.conversation.GetAtAllTagResp.decode(data);
        callBack?.(resp.tag);
      }
        break;

      case proto.event.FuncRequestEventName.GetOneConversation: {
        let resp = proto.sdk.conversation.GetOneConversationResp.decode(data);
        callBack?.(resp.conversation);
      }
        break;

      case proto.event.FuncRequestEventName.GetMultipleConversation: {
        let resp = proto.sdk.conversation.GetMultipleConversationResp.decode(data);
        callBack?.(resp.conversationList);
      }
        break;

      case proto.event.FuncRequestEventName.HideAllConversations: {
        let resp = proto.sdk.conversation.HideAllConversationsResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetConversationDraft: {
        let resp = proto.sdk.conversation.SetConversationDraftResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetConversation: {
        let resp = proto.sdk.conversation.SetConversationResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetTotalUnreadMsgCount: {
        let resp = proto.sdk.conversation.GetTotalUnreadMsgCountResp.decode(data);
        callBack?.(resp.totalUnreadCount);
      }
        break;

      case proto.event.FuncRequestEventName.GetConversationIDBySessionType: {
        let resp = proto.sdk.conversation.GetConversationIDBySessionTypeResp.decode(data);
        callBack?.(resp.conversationID);
      }
        break;

      case proto.event.FuncRequestEventName.FindMessageList: {
        let resp = proto.sdk.message.FindMessageListResp.decode(data);
        callBack?.(resp.totalCount, resp.findResultItems);
      }
        break;

      case proto.event.FuncRequestEventName.GetHistoryMessageList: {
        let resp = proto.sdk.message.GetHistoryMessageListResp.decode(data);
        callBack?.(resp.messageList, resp.isEnd);
      }
        break;

      case proto.event.FuncRequestEventName.RevokeMessage: {
        let resp = proto.sdk.message.RevokeMessageResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.TypingStatusUpdate: {
        let resp = proto.sdk.message.TypingStatusUpdateResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.MarkConversationMessageAsRead: {
        let resp = proto.sdk.conversation.MarkConversationMessageAsReadResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.MarkAllConversationMessageAsRead: {
        let resp = proto.sdk.conversation.MarkAllConversationMessageAsReadResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteMessageFromLocal: {
        let resp = proto.sdk.message.DeleteAllMessageFromLocalResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteMessage: {
        let resp = proto.sdk.message.DeleteMessageResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteAllMsgFromLocalAndServer: {
        let resp = proto.sdk.message.DeleteAllMsgFromLocalAndServerResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteAllMessageFromLocal: {
        let resp = proto.sdk.message.DeleteAllMessageFromLocalResp.decode(data);
        callBack?.(suc);
      }
        break;
      case proto.event.FuncRequestEventName.ClearConversationAndDeleteAllMsg: {
        let resp = proto.sdk.conversation.ClearConversationAndDeleteAllMsgResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteConversationAndDeleteAllMsg: {
        let resp = proto.sdk.conversation.DeleteConversationAndDeleteAllMsgResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.InsertSingleMessageToLocal: {
        let resp = proto.sdk.message.InsertSingleMessageToLocalResp.decode(data);
        callBack?.(resp.msg);
      }
        break;

      case proto.event.FuncRequestEventName.InsertGroupMessageToLocal: {
        let resp = proto.sdk.message.InsertGroupMessageToLocalResp.decode(data);
        callBack?.(resp.msg);
      }
        break;

      case proto.event.FuncRequestEventName.SearchLocalMessages: {
        let resp = proto.sdk.message.SearchLocalMessagesResp.decode(data);
        callBack?.(resp.count, resp.searchResultItems);
      }
        break;

      case proto.event.FuncRequestEventName.SetMessageLocalEx: {
        let resp = proto.sdk.message.SetMessageLocalExResp.decode(data);
        callBack?.(resp.success);
      }
        break;

      case proto.event.FuncRequestEventName.SearchConversation: {
        let resp = proto.sdk.conversation.SearchConversationResp.decode(data);
        callBack?.(resp.conversationList);
      }
        break;

      case proto.event.FuncRequestEventName.CreateTextMessage: {
        let resp = proto.sdk.message.CreateTextAtMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateAdvancedTextMessage: {
        let resp = proto.sdk.message.CreateAdvancedTextMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateTextAtMessage: {
        let resp = proto.sdk.message.CreateTextAtMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateLocationMessage: {
        let resp = proto.sdk.message.CreateLocationMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateCustomMessage: {
        let resp = proto.sdk.message.CreateCustomMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateQuoteMessage: {
        let resp = proto.sdk.message.CreateQuoteMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateAdvancedQuoteMessage: {
        let resp = proto.sdk.message.CreateAdvancedQuoteMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;


      case proto.event.FuncRequestEventName.CreateCardMessage: {
        let resp = proto.sdk.message.CreateCardMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateImageMessage: {
        let resp = proto.sdk.message.CreateImageMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateSoundMessage: {
        let resp = proto.sdk.message.CreateSoundMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateVideoMessage: {
        let resp = proto.sdk.message.CreateVideoMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateFileMessage: {
        let resp = proto.sdk.message.CreateFileMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateMergerMessage: {
        let resp = proto.sdk.message.CreateMergerMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateFaceMessage: {
        let resp = proto.sdk.message.CreateFaceMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateForwardMessage: {
        let resp = proto.sdk.message.CreateForwardMessageResp.decode(data);
        callBack?.(resp.message);
      }
        break;

      case proto.event.FuncRequestEventName.GetSelfUserInfo: {
        let resp = proto.sdk.user.GetSelfUserInfoResp.decode(data);
        callBack?.(resp.user);
      }
        break;

      case proto.event.FuncRequestEventName.SetSelfInfo: {
        let resp = proto.sdk.user.SetSelfInfoResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetUsersInfo: {
        let resp = proto.sdk.user.GetUsersInfoResp.decode(data);
        callBack?.(resp.users);
      }
        break;

      case proto.event.FuncRequestEventName.SubscribeUsersOnlineStatus: {
        let resp = proto.sdk.user.SubscribeUsersOnlineStatusResp.decode(data);
        callBack?.(resp.status);
      }
        break;

      case proto.event.FuncRequestEventName.UnsubscribeUsersOnlineStatus: {
        let resp = proto.sdk.user.UnsubscribeUsersOnlineStatusResp.decode(data);
        callBack?.(suc);
      }
        break;
    }

    if (!suc) {
      errCallBack?.(errCode, errMsg)
    }
  }
}


