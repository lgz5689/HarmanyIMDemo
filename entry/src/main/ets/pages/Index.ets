import { hilog } from '@kit.PerformanceAnalysisKit';
import { IMConfig, InitSDK, PlatformID, RedirectStdOut, UnInitSDK, LoginArgs, Login } from "imsdk"
import { LogLevel } from 'imsdk/src/main/ets/Enum';
import { ConnListener } from '../listener/ConnListener';
import { common } from '@kit.AbilityKit';

@Entry
@Component
struct Index {
  @State message: string = 'Login';

  aboutToAppear(): void {
    let context = getContext(this) as common.UIAbilityContext;
    let filesDir = context.filesDir;
    // 重定向 native printf -> file
    RedirectStdOut(filesDir)
    const config: IMConfig = {
      platformID: PlatformID.AndroidPlatformID,
      apiAddr: "http://192.168.101.9:10002",
      wsAddr: "ws://192.168.101.9:10001",
      dataDir: filesDir + "/openim/",
      logLevel: LogLevel.Debug,
      isLogStandardOutput: true,
      logFilePath: filesDir + "/openim/log",
      isExternalExtensions: false
    }
    const connListener = new ConnListener()
    let suc = InitSDK(config, connListener)
    if (suc) {
      hilog.info(0xFF00, "[imsdk]", "InitSDK Success")
    } else {
      hilog.info(0xFF00, "[imsdk]", "InitSDK Failed")
    }
  }

  build() {
    RelativeContainer() {
      Text(this.message)
        .id('login')
        .fontSize(50)
        .fontWeight(FontWeight.Bold)
        .alignRules({
          center: { anchor: '__container__', align: VerticalAlign.Center },
          middle: { anchor: '__container__', align: HorizontalAlign.Center }
        })
        .onClick(() => {
          let uid = "test"
          let token =
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJVc2VySUQiOiJ0ZXN0IiwiUGxhdGZvcm1JRCI6MiwiZXhwIjoxNzM3OTgzNjgwLCJuYmYiOjE3MzAyMDczODAsImlhdCI6MTczMDIwNzY4MH0.MjoEKjqetlLqUsgAQz2ux1C_nB3PFb3y6H3dyQHDck0"
          Login((suc, errCode, errMsg) => {

          }, uid, token)
        })
    }
    .height('100%')
    .width('100%')
  }
}