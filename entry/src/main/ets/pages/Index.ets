import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';
import { proto, imsdk } from "imsdk"

@Entry
@Component
struct Index {
  @State ip: string = '192.168.101.4'
  @State uid: string = "test1"
  @State token: string = ""
  // 测试
  @State uid2: string = '4860535712'
  @State uid3: string = '3559000694'
  @State myCreateGroupID: string = '2724778243'
  @State conversationID: string = 'sg_413631798'

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
    console.info("initsdk")
    imsdk.InitSDK(config)
  }

  build() {
    Column() {
    }
    .height('100%')
    .width('100%')
  }
}
