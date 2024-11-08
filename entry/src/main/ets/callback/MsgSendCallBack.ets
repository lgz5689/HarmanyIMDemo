import { Message } from 'imsdk';
import { IMsgSendCallBack } from 'imsdk/src/main/ets/MessageHandle';

export class SendMsgCallBack implements IMsgSendCallBack {
  onError(code: number, errMsg: string):void {
    console.error('+++++++++++++++++++++SendMsgCallBack------onError',String(code),errMsg)
  }
  onSuccess(msg: Message):void {
    console.error('+++++++++++++++++++++SendMsgCallBack------onSuccess',JSON.stringify(msg))
  }
  onProgress(progress: number):void {
    console.error('+++++++++++++++++++++SendMsgCallBack------onProgress',progress)
  }
}