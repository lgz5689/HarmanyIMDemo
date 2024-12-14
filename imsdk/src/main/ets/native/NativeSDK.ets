import native from "libimsdk.so"
import logger from "../utils/Logger"
import { openim } from "../proto/proto"
import { JSON } from "@kit.ArkTS"

export function Redirect(dir: string) {
  native.redirect(dir)
}

export function Init(handler: (result: openim.ffi.FfiResult) => void) {
  native.init((data: ArrayBuffer) => {
    try {
      let uint8Array = new Uint8Array(data)
      let result = openim.ffi.FfiResult.decode(uint8Array)
      handler(result)
    } catch (e) {
      logger.error(e.toString())
    }
  })
}

export function Call(handlerId: number, funcName: openim.event.FuncRequestEventName, data: Uint8Array) {
  try {
    let request = openim.ffi.FfiRequest.create({
      operationID: "",
      handleID: handlerId,
      funcName: funcName,
      data: data
    })
    let buffer: Uint8Array = openim.ffi.FfiRequest.encode(request).finish()
    console.log("JS Call API:", handlerId, funcName, buffer.length, JSON.stringify(buffer));
    native.request(buffer.buffer)

  } catch (e) {
    console.log(e)
  }

}

export function DropHandler(handleId: number) {
  native.drop(handleId)
}