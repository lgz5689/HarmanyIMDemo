import native from "libimsdk.so"
import { APIKey } from "./APIKey"
import { hilog } from "@kit.PerformanceAnalysisKit"
import logger from "../utils/Logger"


export function Redirect(dir: string) {
  native.redirect(dir)
}

export function SetMsgHandler() {
  native.setMsgHandler((msgId, data) => {
    logger.info(`recv msg -> ${msgId} ->${data}`)
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