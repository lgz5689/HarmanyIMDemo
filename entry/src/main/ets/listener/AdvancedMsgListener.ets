import { IAdvancedMsgListener, Message, MessageReceipt, MessageRevoked } from "imsdk";

export class AdvancedMsgListener implements IAdvancedMsgListener {
  onRecvNewMessage(message: Message): void {
    console.error('==========================onRecvNewMessage',JSON.stringify(message))
  }

  onRecvC2CReadReceipt(msgReceiptList: MessageReceipt[]): void{
    console.error('==========================onRecvC2CReadReceipt',JSON.stringify(msgReceiptList))
  };

  onRecvGroupReadReceipt(groupMsgReceiptList: MessageReceipt[]): void{
    console.error('==========================onRecvGroupReadReceipt',JSON.stringify(groupMsgReceiptList))
  };

  onNewRecvMessageRevoked(messageRevoked: MessageRevoked): void{
    console.error('==========================onNewRecvMessageRevoked',JSON.stringify(messageRevoked))
  };

  onRecvMessageExtensionsChanged(msgID: string, reactionExtensionList: string): void{
    console.error('==========================onRecvMessageExtensionsChanged',msgID,reactionExtensionList)
  };

  onRecvMessageExtensionsDeleted(msgID: string, reactionExtensionKeyList: string): void{
    console.error('==========================onRecvMessageExtensionsDeleted',msgID,reactionExtensionKeyList)
  };

  onRecvMessageExtensionsAdded(msgID: string, reactionExtensionList: string): void{
    console.error('==========================onRecvMessageExtensionsAdded',msgID,reactionExtensionList)
  };

  onRecvOfflineNewMessage(message: Message): void{
    console.error('==========================onRecvOfflineNewMessage',JSON.stringify(message))
  };

  onMsgDeleted(message: Message): void{
    console.error('==========================onMsgDeleted',JSON.stringify(message))
  };

  onRecvOnlineOnlyMessage(message: Message): void{
    console.error('==========================onRecvOnlineOnlyMessage',JSON.stringify(message))
  };
}