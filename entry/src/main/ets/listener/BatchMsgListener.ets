import { IBatchMsgListener, Message, UserInfo } from "imsdk";

export class BatchMsgListener implements IBatchMsgListener {
  onRecvNewMessages(messageList: Message[]): void{
    console.error('==========================onRecvNewMessages',JSON.stringify(messageList))
  };

  onRecvOfflineNewMessages(messageList: Message[]): void{
    console.error('==========================onRecvOfflineNewMessages',JSON.stringify(messageList))
  };
}