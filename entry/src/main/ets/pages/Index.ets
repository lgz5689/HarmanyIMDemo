import { hilog } from '@kit.PerformanceAnalysisKit';
import { IMConfig, InitSDK, PlatformID, RedirectStdOut, UnInitSDK, Login, CreateTextMessage, SendMessage,
  GetLoginStatus,
  GetSelfUserInfo,
  UserInfo,
  AddFriend,
  AddBlack,
  DeleteFriend,
  RemoveBlack,
  GetFriendListPage,
  FriendInfo,
  CreateGroup,
  GroupInfo,
  GetGroupMemberList,
  GroupMember,
  GetJoinedGroupListPage,
  GetConversationListSplit,
  Conversation,
  GetTotalUnreadMsgCount,
  GetAdvancedHistoryMessageList,
  AdvancedMessageResult,
  IsJoinGroup} from "imsdk"
import { LogLevel } from 'imsdk/src/main/ets/Enum';
import { ConnListener } from '../listener/ConnListener';
import { common } from '@kit.AbilityKit';
import { setAdvancedMsgListener,
  setBatchMsgListener,
  setConversationListener,
  setFriendShipListener,
  setGroupListener,
  setUserListener} from 'imsdk/src/main/ets/MessageHandle';
import { ConversationListener } from '../listener/ConversationListener';
import { SendMsgCallBack } from '../callback/MsgSendCallBack';
import { AdvancedMsgListener } from '../listener/AdvancedMsgListener';
import { FriendShipListener } from '../listener/FriendShipListener';
import { GroupListener } from '../listener/GroupListener';
import { UserListener } from '../listener/UserListener';
import { BatchMsgListener } from '../listener/BatchMsgListener';

@Entry
@Component
struct Index {
  @State ip:string = '192.168.2.20'
  @State uid:string = "4350531864"
  @State token:string = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiI0MzUwNTMxODY0IiwiUGxhdGZvcm1JRCI6MiwiZXhwIjoxNzM5MTc5ODEyLCJuYmYiOjE3MzE0MDM1MTIsImlhdCI6MTczMTQwMzgxMn0.troejURlyjGi_2u67IwQnu6cYovsYTEJPryOT2Arw0w"

  // 测试
  @State uid2:string = '4860535712'
  @State uid3:string = '3559000694'
  @State myCreateGroupID:string = '2724778243'
  @State conversationID:string = 'sg_413631798'

  aboutToAppear(): void {
    console.error('--------------------aboutToAppear')
    let context = getContext(this) as common.UIAbilityContext;
    let filesDir = context.filesDir;
    // 重定向 native printf -> file
    RedirectStdOut(filesDir)
    const config: IMConfig = {
      platformID: PlatformID.AndroidPlatformID,
      apiAddr: `http://${this.ip}:10002`,
      wsAddr: `ws://${this.ip}:10001`,
      dataDir: filesDir + "/openim/",
      logLevel: LogLevel.Debug,
      isLogStandardOutput: true,
      logFilePath: filesDir + "/openim/log",
      isExternalExtensions: false
    }
    let suc = InitSDK(config, new ConnListener())
    if (suc) {
      hilog.info(0xFF00, "[imsdk]", "InitSDK Success")
    } else {
      hilog.info(0xFF00, "[imsdk]", "InitSDK Failed")
    }
  }

  setListener(){
    setAdvancedMsgListener(new AdvancedMsgListener())
    setConversationListener(new ConversationListener())
    setFriendShipListener(new FriendShipListener())
    setGroupListener(new GroupListener)
    setUserListener(new UserListener)
  }

  setBatchListener(){
    setBatchMsgListener(new BatchMsgListener())
  }

  build() {
    Column() {
      Button('LOGIN').onClick(() => {
        this.aboutToAppear()
        Login((suc, errCode, errMsg) => {
            if (suc) {
              this.setListener()
              hilog.info(0xFF00, "Index", "Login Suc")
            } else {
              hilog.info(0xFF00, "Index", "Login Err:" + errMsg)
            }
          }, this.uid, this.token)
        })
      Button('UnInitSDK').onClick(() => {
        UnInitSDK()
      })
      Button('setBatchListener').onClick(()=>{
        this.setBatchListener()
      })

      Text('------------User-----------------')
      Button('GetLoginStatus').onClick(()=>{
        const status = GetLoginStatus()
        console.error('---------------------GetLoginStatus',status)
      })
      Button('GetSelfUserInfo').onClick(()=>{
        GetSelfUserInfo((result: UserInfo, errCode: number, errMsg: string) =>{
          console.error('---------------------GetSelfUserInfo', JSON.stringify(result),errCode,errMsg)
        })
      })

      Text('------------Message-----------------')
      Button('SendTextMessage').onClick(()=>{
        const msg = CreateTextMessage('123')
        console.error('---------------------CreateTextMessage',JSON.stringify(msg))
        SendMessage(new SendMsgCallBack(),msg,this.uid2,'',{
          title: '1',
          desc: '2',
          ex: '',
          iOSPushSound: '',
          iOSBadgeCount: false,
          signalInfo: '',
        },false)
      })
      Button('GetAdvancedHistoryMessageList').onClick(()=>{
        GetAdvancedHistoryMessageList((result: AdvancedMessageResult, errCode: number, errMsg: string) =>{
          console.error('---------------------GetAdvancedHistoryMessageList', JSON.stringify(result),errCode,errMsg)
        },{
          lastMinSeq: 0,
          conversationID: this.conversationID,
          startClientMsgID: '',
          count: 20,
        })
      })

      Text('------------relation-----------------')
      Button('AddFriend').onClick(()=>{
        AddFriend((result: boolean, errCode: number, errMsg: string) =>{
          console.error('---------------------AddFriend', result,errCode,errMsg)
        },{
          fromUserID: this.uid,
          toUserID: this.uid2,
          reqMsg: 'AddFriend',
          ex: ''
        })
      })
      Button('AddBlack').onClick(()=>{
        AddBlack((result: boolean, errCode: number, errMsg: string) =>{
          console.error('---------------------AddBlack', result,errCode,errMsg)
        },this.uid2,'')
      })
      Button('DeleteFriend').onClick(()=>{
        DeleteFriend((result: boolean, errCode: number, errMsg: string) =>{
          console.error('---------------------DeleteFriend', result,errCode,errMsg)
        },this.uid2)
      })
      Button('RemoveBlack').onClick(()=>{
        RemoveBlack((result: boolean, errCode: number, errMsg: string) =>{
          console.error('---------------------RemoveBlack', result,errCode,errMsg)
        },this.uid2)
      })
      Button('GetFriendListPage').onClick(()=>{
        GetFriendListPage((result: FriendInfo[], errCode: number, errMsg: string) =>{
          console.error('---------------------GetFriendListPage', JSON.stringify(result),errCode,errMsg)
        },0,500,false)
      })

      Text('------------group-----------------')
      Button('CreateGroup').onClick(()=>{
        CreateGroup((result: Partial<GroupInfo>, errCode: number, errMsg: string) =>{
          console.error('---------------------createGroup', JSON.stringify(result),errCode,errMsg)
          this.myCreateGroupID = result.groupID ?? ''
        },{
          memberUserIDs: [this.uid2,this.uid3],
          groupInfo:  {
            groupName: `123-${new Date().getTime()}`,
            groupType: 2,
          },
          adminUserIDs: [],
          ownerUserID: this.uid,
        })
      })
      Button('GetGroupMemberList').onClick(()=>{
        console.error('---------------------GetGroupMemberList', this.myCreateGroupID)
        GetGroupMemberList((result:  GroupMember[], errCode: number, errMsg: string) =>{
          console.error('---------------------GetGroupMemberList', JSON.stringify(result),errCode,errMsg)
        },this.myCreateGroupID,0,0,20)
      })
      Button('GetJoinedGroupListPage').onClick(()=>{
        GetJoinedGroupListPage((result:  GroupInfo[], errCode: number, errMsg: string) =>{
          console.error('---------------------GetJoinedGroupListPage', JSON.stringify(result),errCode,errMsg)
        },0,100)
      })
      Button('IsJoinGroup').onClick(()=>{
        IsJoinGroup((result: boolean, errCode: number, errMsg: string) =>{
          console.error('---------------------IsJoinGroup', JSON.stringify(result),errCode,errMsg)
        },this.myCreateGroupID)
      })

      Text('------------Conversation-----------------')
      Button('GetConversationListSplit').onClick(()=>{
        GetConversationListSplit((result: Conversation[], errCode: number, errMsg: string) =>{
          console.error('---------------------GetConversationListSplit', JSON.stringify(result),errCode,errMsg)
        },0,1)
      })
      Button('GetTotalUnreadMsgCount').onClick(()=>{
        GetTotalUnreadMsgCount((result: number, errCode: number, errMsg: string) =>{
          console.error('---------------------GetTotalUnreadMsgCount', result,errCode,errMsg)
        })
      })

    }
    .height('100%')
    .width('100%')
  }
}
