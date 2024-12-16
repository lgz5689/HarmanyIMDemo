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

  export function DispatchEvent(result: proto.ffi.FfiResult) {
    let errCode = result.errCode;
    let errMsg = result.errMsg;
    let handleId = result.handleID instanceof Long ? result.handleID.toNumber() : result.handleID;
    let eventName = result.funcName;
    let data = result.data;
    let suc = errCode == 0;
    let callBack = callBackDic.get(handleId)

    switch (eventName) {
      case proto.event.FuncRequestEventName.None:
        break;
      case proto.event.FuncRequestEventName.InitSDK: {
        let resp = proto.init.InitSDKResp.decode(data);
        callBack?.(resp.suc);
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

      case proto.event.FuncRequestEventName.UploadLogs: {
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

      case proto.event.FuncRequestEventName.EventOnUploadLogsProgress: {
        let uploadLogCallBack = uploadLogsCallBackDic.get(handleId)
        if (uploadLogCallBack != undefined) {
          let resp = proto.event.EventOnUploadFileProgressData.decode(data);
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

      case proto.event.FuncRequestEventName.EventOnUserStatusChanged: {
        let resp = proto.event.EventOnUserOnlineStatusChangedData.decode(data);
        userListener?.onUserStatusChanged(resp.userID, resp.platforms)
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUserCommandAdd: {
        let resp = proto.event.EventOnUserCommandAddData.decode(data);
        userListener?.onUserCommandAdd(resp.command);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUserCommandDelete: {
        let resp = proto.event.EventOnUserCommandDeleteData.decode(data);
        userListener?.onUserCommandDelete(resp.command);
      }
        break;

      case proto.event.FuncRequestEventName.EventOnUserCommandUpdate: {
        let resp = proto.event.EventOnUserCommandUpdateData.decode(data);
        userListener?.onUserCommandUpdate(resp.command);
      }
        break;

      case proto.event.FuncRequestEventName.CreateGroup: {
        let resp = CreateGroupResp.decode(data);
        callBack?.(resp.GroupInfo);
      }
        break;

      case proto.event.FuncRequestEventName.JoinGroup: {
        let resp = JoinGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.QuitGroup: {
        let resp = QuitGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DismissGroup: {
        let resp = DismissGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ChangeGroupMute: {
        let resp = ChangeGroupMuteResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ChangeGroupMemberMute: {
        let resp = ChangeGroupMemberMuteResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.TransferGroupOwner: {
        let resp = TransferGroupOwnerResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.KickGroupMember: {
        let resp = KickGroupMemberResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetGroupInfo: {
        let resp = SetGroupInfoResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetGroupMemberInfo: {
        let resp = SetGroupMemberInfoResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetJoinedGroups: {
        let resp = GetJoinedGroupsResp.decode(data);
        callBack?.([resp.Groups.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetJoinedGroupsPage: {
        let resp = GetJoinedGroupsPageResp.decode(data);
        callBack?.([resp.Groups.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetSpecifiedGroupsInfo: {
        let resp = GetSpecifiedGroupsInfoResp.decode(data);
        callBack?.([resp.Groups.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.SearchGroups: {
        let resp = SearchGroupsResp.decode(data);
        callBack?.([resp.Groups.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupMemberOwnerAndAdmin: {
        let resp = GetGroupMemberOwnerAndAdminResp.decode(data);
        callBack?.([resp.Members.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupMembersByJoinTimeFilter: {
        let resp = GetGroupMembersByJoinTimeFilterResp.decode(data);
        callBack?.([resp.Members.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetSpecifiedGroupMembersInfo: {
        let resp = GetSpecifiedGroupMembersInfoResp.decode(data);
        callBack?.([resp.Members.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupMembers: {
        let resp = GetGroupMembersResp.decode(data);
        callBack?.([resp.Members.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetGroupRequest: {
        let resp = GetGroupRequestResp.decode(data);
        callBack?.([resp.Requests.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.SearchGroupMembers: {
        let resp = SearchGroupMembersResp.decode(data);
        callBack?.([resp.Members.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.IsJoinGroup: {
        let resp = IsJoinGroupResp.decode(data);
        callBack?.(resp.Joined);
      }
        break;

      case proto.event.FuncRequestEventName.GetUsersInGroup: {
        let resp = GetUsersInGroupResp.decode(data);
        callBack?.([resp.UserIDs.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.InviteUserToGroup: {
        let resp = InviteUserToGroupResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.HandleGroupRequest: {
        let resp = HandleGroupRequestResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetSpecifiedFriends: {
        let resp = GetSpecifiedFriendsResp.decode(data);
        callBack?.([resp.Friends.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.AddFriend: {
        let resp = AddFriendResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetFriendRequests: {
        let resp = GetFriendRequestsResp.decode(data);
        callBack?.([resp.Requests.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.HandleFriendRequest: {
        let resp = HandleFriendRequestResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.CheckFriend: {
        let resp = CheckFriendResp.decode(data);
        callBack?.([resp.Result.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteFriend: {
        let resp = DeleteFriendResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetFriends: {
        let resp = GetFriendsResp.decode(data);
        callBack?.([resp.Friends.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetFriendsPage: {
        let resp = GetFriendsPageResp.decode(data);
        callBack?.([resp.Friends.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.SearchFriends: {
        let resp = SearchFriendsResp.decode(data);
        callBack?.([resp.Friends.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.AddBlack: {
        let resp = AddBlackResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteBlack: {
        let resp = DeleteBlackResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetBlacks: {
        let resp = GetBlacksResp.decode(data);
        callBack?.([resp.Blacks.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.UpdateFriend: {
        let resp = UpdateFriendResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetAllConversationList: {
        let resp = GetAllConversationListResp.decode(data);
        callBack?.([resp.ConversationList.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetConversationListSplit: {
        let resp = GetConversationListSplitResp.decode(data);
        callBack?.([resp.ConversationList.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.HideConversation: {
        let resp = HideConversationResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetAtAllTag: {
        let resp = GetAtAllTagResp.decode(data);
        callBack?.(resp.Tag);
      }
        break;

      case proto.event.FuncRequestEventName.GetOneConversation: {
        let resp = GetOneConversationResp.decode(data);
        callBack?.(resp.Conversation);
      }
        break;

      case proto.event.FuncRequestEventName.GetMultipleConversation: {
        let resp = GetMultipleConversationResp.decode(data);
        callBack?.([resp.ConversationList.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.HideAllConversations: {
        let resp = HideAllConversationsResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetConversationDraft: {
        let resp = SetConversationDraftResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.SetConversation: {
        let resp = SetConversationResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetTotalUnreadMsgCount: {
        let resp = GetTotalUnreadMsgCountResp.decode(data);
        callBack?.(resp.TotalUnreadCount);
      }
        break;

      case proto.event.FuncRequestEventName.GetConversationIdbySessionType: {
        let resp = GetConversationIDBySessionTypeResp.decode(data);
        callBack?.(resp.ConversationID);
      }
        break;

      case proto.event.FuncRequestEventName.FindMessageList: {
        let resp = FindMessageListResp.decode(data);
        let args = new object[]
        {
          resp.TotalCount, resp.FindResultItems.ToArray()
        }
        ;
        callBack?.(args);
      }
        break;

      case proto.event.FuncRequestEventName.GetHistoryMessageList: {
        let resp = GetHistoryMessageListResp.decode(data);
        callBack?.(resp);
      }
        break;

      case proto.event.FuncRequestEventName.RevokeMessage: {
        let resp = RevokeMessageResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.TypingStatusUpdate: {
        let resp = TypingStatusUpdateResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.MarkConversationMessageAsRead: {
        let resp = MarkConversationMessageAsReadResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.MarkAllConversationMessageAsRead: {
        let resp = MarkAllConversationMessageAsReadResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteMessageFromLocalStorage: {
        let resp = DeleteMessageFromLocalStorageResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteMessage: {
        let resp = DeleteMessageResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteAllMsgFromLocalAndServer: {
        let resp = DeleteAllMsgFromLocalAndServerResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteAllMessageFromLocalStorage: {
        let resp = DeleteAllMessageFromLocalStorageResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ClearConversationAndDeleteAllMsg: {
        let resp = ClearConversationAndDeleteAllMsgResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.DeleteConversationAndDeleteAllMsg: {
        let resp = DeleteConversationAndDeleteAllMsgResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.InsertSingleMessageToLocalStorage: {
        let resp = InsertSingleMessageToLocalStorageResp.decode(data);
        callBack?.(resp.Msg);
      }
        break;

      case proto.event.FuncRequestEventName.InsertGroupMessageToLocalStorage: {
        let resp = InsertGroupMessageToLocalStorageResp.decode(data);
        callBack?.(resp.Msg);
      }
        break;

      case proto.event.FuncRequestEventName.SearchLocalMessages: {
        let resp = SearchLocalMessagesResp.decode(data);
        let args = new object[]
        {
          resp.SearchResult.TotalCount, resp.SearchResult.SearchResultItems
        }
        ;
        callBack?.(args);
      }
        break;

      case proto.event.FuncRequestEventName.SetMessageLocalEx: {
        let resp = SetMessageLocalExResp.decode(data);
        callBack?.(resp.Success);
      }
        break;

      case proto.event.FuncRequestEventName.SearchConversation: {
        let resp = SearchConversationResp.decode(data);
        callBack?.([resp.ConversationList.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.CreateTextMessage: {
        let resp = CreateTextAtMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateAdvancedTextMessage: {
        let resp = CreateAdvancedTextMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateTextAtMessage: {
        let resp = CreateTextAtMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateLocationMessage: {
        let resp = CreateLocationMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateCustomMessage: {
        let resp = CreateCustomMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateQuoteMessage: {
        let resp = CreateQuoteMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateAdvancedQuoteMessage: {
        let resp = CreateAdvancedQuoteMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;


      case proto.event.FuncRequestEventName.CreateCardMessage: {
        let resp = CreateCardMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateImageMessage: {
        let resp = CreateImageMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateSoundMessage: {
        let resp = CreateSoundMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateVideoMessage: {
        let resp = CreateVideoMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateFileMessage: {
        let resp = CreateFileMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateMergerMessage: {
        let resp = CreateMergerMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateFaceMessage: {
        let resp = CreateFaceMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.CreateForwardMessage: {
        let resp = CreateForwardMessageResp.decode(data);
        callBack?.(resp.Message);
      }
        break;

      case proto.event.FuncRequestEventName.ProcessUserCommandGetAll: {
        let resp = ProcessUserCommandGetAllResp.decode(data);
        callBack?.([resp.Commands.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.GetSelfUserInfo: {
        let resp = GetSelfUserInfoResp.decode(data);
        callBack?.(resp.User);
      }
        break;

      case proto.event.FuncRequestEventName.SetSelfInfo: {
        let resp = SetSelfInfoResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ProcessUserCommandAdd: {
        let resp = ProcessUserCommandAddResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ProcessUserCommandDelete: {
        let resp = ProcessUserCommandDeleteResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.ProcessUserCommandUpdate: {
        let resp = ProcessUserCommandUpdateResp.decode(data);
        callBack?.(suc);
      }
        break;

      case proto.event.FuncRequestEventName.GetUsersInfo: {
        let resp = GetUsersInfoResp.decode(data);
        callBack?.([resp.Users.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.SubscribeUsersOnlineStatus: {
        let resp = SubscribeUsersOnlineStatusResp.decode(data);
        callBack?.([resp.Status.ToArray()]);
      }
        break;

      case proto.event.FuncRequestEventName.UnsubscribeUsersOnlineStatus: {
        let resp = UnsubscribeUsersOnlineStatusResp.decode(data);
        callBack?.(suc);
      }
        break;
    }

    if (!suc) {
      errCallBack?.(errCode, errMsg)
    }
  }
}


