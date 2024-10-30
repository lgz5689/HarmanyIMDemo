import native from "libimsdk.so"
import { APIKey } from "./APIKey"
import logger from "../utils/Logger"
import { ToJson } from "../utils/Json"


export function Redirect(dir: string) {
  native.redirect(dir)
}

export function registerMsgCallBack(handler: (id: number, data: string) => void) {
  native.registerMsgCallBack((msgId, data) => {
    try {
      handler(msgId, data);
    } catch (e) {
      logger.error(e.toString())
    }
  })
}

export function CallAPI<T extends object | null>(key: APIKey, args: object): T | null {
  let data = native.callAPI(key, ToJson(args))
  if (data == "") {
    return null
  } else {
    return JSON.parse(data) as T
  }
}