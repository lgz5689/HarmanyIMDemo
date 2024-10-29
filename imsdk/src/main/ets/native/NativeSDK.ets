import native from "libimsdk.so"
import { APIKey } from "./APIKey"
import logger from "../utils/Logger"


export function Redirect(dir: string) {
  native.redirect(dir)
}

export function registerMsgCallBack(handler: (id: number, data: string) => void) {
  native.registerMsgCallBack((msgId, data) => {
    handler(msgId, data);
  })
}

export function CallAPI<T extends object | null>(key: APIKey, args: string): T | null {
  let data = native.callAPI(key, args)
  if (data == "") {
    return null
  } else {
    return JSON.parse(data) as T
  }
}