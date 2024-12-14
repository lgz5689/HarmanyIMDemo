// import { Conversation, IConversationListener, InputStatesChangedData } from "imsdk";
//
// export class ConversationListener implements IConversationListener {
//   onSyncServerStart(): void{
//     console.error('==========================onSyncServerStart')
//   };
//
//   onSyncServerFinish(): void{
//     console.error('==========================onSyncServerFinish')
//   };
//
//   onSyncServerProgress(progress: number): void{
//     console.error('==========================onSyncServerProgress',progress)
//   };
//
//   onSyncServerFailed(): void{
//     console.error('==========================onSyncServerFailed')
//   };
//
//   onNewConversation(conversationList: Conversation[]): void{
//     console.error('==========================onNewConversation',JSON.stringify(conversationList))
//   };
//
//   onConversationChanged(conversationList: Conversation[]): void{
//     console.error('==========================onConversationChanged',JSON.stringify(conversationList))
//   };
//
//   onTotalUnreadMessageCountChanged(totalUnreadCount: number): void{
//     console.error('==========================onTotalUnreadMessageCountChanged',totalUnreadCount)
//   };
//
//   onConversationUserInputStatusChanged(data: InputStatesChangedData): void{
//     console.error('==========================onConversationUserInputStatusChanged',JSON.stringify(data))
//   };
// }