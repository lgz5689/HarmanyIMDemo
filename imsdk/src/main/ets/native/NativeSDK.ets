import native from "libimsdk.so"
import logger from "../utils/Logger"
import { openim } from "../proto/proto"
import Long from "long"

export function Redirect(dir: string) {
  native.redirect(dir)
}

function drop(handleId: number) {
  native.drop(handleId)
}

export function internal_Init(handler: (result: openim.ffi.FfiResult) => void) {
  native.init((data: ArrayBuffer) => {
    try {
      let uint8Array = new Uint8Array(data)
      let result = openim.ffi.FfiResult.decode(uint8Array)
      handler(result)
      if (result.handleID instanceof Long) {
        drop(result.handleID.toNumber())
      } else if (typeof (result.handleID) == "number") {
        drop(result.handleID)
      }
    } catch (e) {
      logger.error(e.toString())
    }
  })
}

export function call(handlerId: number, funcName: openim.event.FuncRequestEventName, data: Uint8Array) {
  try {
    let request = openim.ffi.FfiRequest.create({
      operationID: "",
      handleID: handlerId,
      funcName: funcName,
      data: data
    })
    let buffer: Uint8Array = openim.ffi.FfiRequest.encode(request).finish()
    console.log("JS Call API:handlerId = ", handlerId, openim.event.FuncRequestEventName[funcName]);
    native.request(buffer.buffer)

  } catch (e) {
    console.log(e)
  }
}
