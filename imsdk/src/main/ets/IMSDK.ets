import { openim } from "./proto/proto"
import { Init, Call, DropHandler } from "./native/NativeSDK"
import logger from "./utils/Logger"
import { dispatchEvent } from "./EventHandler";

function OnRecvEvent(result: openim.ffi.FfiResult) {
  dispatchEvent(result.handleID as number, result.funcName, result.errCode, result.errMsg, result.data)
}

let handlerId = 0

function genHandlerId(): number {
  handlerId = handlerId + 1
  return handlerId
}


export function InitSDK(config: openim.init.IMConfig) {
  Init(OnRecvEvent)

  let req = openim.init.InitSDKReq.create({
    config: config
  })

  Call(genHandlerId(), openim.event.FuncRequestEventName.InitSDK, openim.init.InitSDKReq.encode(req).finish())

}