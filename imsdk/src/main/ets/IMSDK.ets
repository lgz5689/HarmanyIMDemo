import { IBoolValue, LoginArgs, IMConfig, InitSDKArgs } from "./Interface";
import { IConnListener } from "./Listener";
import { dispatchMsg } from "./MessageHandle";
import { APIKey } from "./native/APIKey";
import { CallAPI, Redirect, registerMsgCallBack } from "./native/NativeSDK";
import { ToJson } from "./utils/Json";
import logger from "./utils/Logger";

let operationId = 0

function GetOperationId(): string {
  operationId = operationId + 1;
  return operationId.toString()
}

export function RedirectStdOut(dir: string) {
  Redirect(dir)
}

export function InitSDK(config: IMConfig, conn: IConnListener): boolean {
  registerMsgCallBack(dispatchMsg)
  let initSDKArgs: InitSDKArgs = {
    operationId: GetOperationId(),
    config: ToJson(config),
  }
  let res = CallAPI<IBoolValue>(APIKey.API_InitSDK, ToJson(initSDKArgs)) as IBoolValue
  return res.value;
}


export function UnInitSDK(): void {

}

export function Login(cb: (suc: boolean, errCode: number, errMsg: string) => void, uid: string, token: string): void {
  const args: LoginArgs = {
    operationId: GetOperationId(),
    uid: uid,
    token: token
  }
  CallAPI(APIKey.API_Login, ToJson(args))
}
