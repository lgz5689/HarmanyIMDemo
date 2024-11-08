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
  FriendInfo} from "imsdk"
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
  @State uid:string = "2793860650"
  @State token:string = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiIyNzkzODYwNjUwIiwiUGxhdGZvcm1JRCI6MiwiZXhwIjoxNzM4ODEzNTgzLCJuYmYiOjE3MzEwMzcyODMsImlhdCI6MTczMTAzNzU4M30.zf-1fU2Ne7NMl27wHJ8WIvsFOsa-7xCH3lWpXbYYosA"

  // 测试目标用户 管理后台创建
  @State uid2:string = '7843965975'

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

    }
    .height('100%')
    .width('100%')
  }
}
