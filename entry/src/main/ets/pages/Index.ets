import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';
import { proto, imsdk } from "imsdk"
import { SendMessageCallBack } from '../callback/SendMessageCallBack';

@Entry
@Component
struct Index {
  @State ip: string = '192.168.101.4'
  @State uid: string = "test1"
  @State token: string =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiJ0ZXN0MSIsIlBsYXRmb3JtSUQiOjExLCJleHAiOjE3NDIxNzI4NDQsIm5iZiI6MTczNDM5NjU0NCwiaWF0IjoxNzM0Mzk2ODQ0fQ.3V5S3amP3P8r5SlMyBtua70ilxFye8BqfkcEhyBaV9w"
  @State friend: proto.sdk.shared.IIMFriend | null = null

  aboutToAppear(): void {
    console.info("IMDemo", '--------------------aboutToAppear')
    let context = getContext(this) as common.UIAbilityContext;
    let filesDir = context.filesDir;
    const config = proto.init.IMConfig.create({
      platform: proto.sdk.common.Platform.HarmonyOS,
      apiAddr: `http://${this.ip}:10002`,
      wsAddr: `ws://${this.ip}:10001`,
      dataDir: filesDir + "/openim/",
      logLevel: proto.sdk.common.LogLevel.LevelDebug,
      isLogStandardOutput: false,
      logFilePath: filesDir + "/openim/log",
      dbPath: filesDir + "/openim"
    })
    imsdk.SetErrCallBack((errCode: number, errMsg) => {
      console.error(errMsg)
    })
    imsdk.InitSDK((suc: boolean) => {
      if (suc) {
        imsdk.Login((suc: boolean) => {
          if (suc) {
            console.log("Login Success");
          } else {
            console.log("Login Failed");
          }
        }, this.uid, this.token)
      }
    }, config)
  }

  build() {
    Column() {
      Button("GetFirstFriend")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.getFirstFriend()
        })
      Button("SendTestMsg")
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .onClick(() => {
          this.sendTestMsg()
        })
    }
    .height('100%')
    .width('100%')
  }

  getFirstFriend() {
    imsdk.GetFriends((friends: proto.sdk.shared.IIMFriend[]) => {
      console.log("好友数量:" + friends.length)
      if (friends.length > 0) {
        console.log("指定好友成功")
        this.friend = friends[0]
      }
    }, true)
  }

  sendTestMsg() {
    if (this.friend == null) {
      console.log("test friend is null");
      return
    }
    let friendUserId = this.friend.friendUserID as string
    imsdk.GetOneConversation((conversation: proto.sdk.shared.IIMConversation) => {
      console.log("GetConversation", conversation.conversationID)
      imsdk.CreateTextMessage((msg: proto.sdk.shared.IIMMessage) => {
        console.log("CreateTextMsg", msg.clientMsgID, msg.textElem?.content)
        imsdk.SendMessage(new SendMessageCallBack(), msg, friendUserId, "", false)
      }, "hello open harmany")
    }, proto.sdk.common.SessionType.Single, friendUserId)
  }
}
