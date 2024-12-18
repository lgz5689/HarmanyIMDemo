import { listener, proto } from 'imsdk';

export class SendMessageCallBack implements listener.ISendMsg {
  onError(code: number, errMsg: string): void {
    console.log('+++++++++++++++++++++SendeventCallBack------onError', String(code), errMsg)
  }

  onSuccess(msg: proto.sdk.shared.IIMMessage): void {
    console.log('+++++++++++++++++++++SendMsgCallBack------onSuccess', JSON.stringify(msg))
  }

  onProgress(progress: number): void {
    console.log('+++++++++++++++++++++SendMsgCallBack------onProgress', progress)
  }
}