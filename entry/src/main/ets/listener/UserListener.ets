import { IUserListener, OnlineStatus, UserInfo } from "imsdk";

export class UserListener implements IUserListener {
  onSelfInfoUpdated(userInfo: UserInfo): void{
    console.error('==========================onSelfInfoUpdated',JSON.stringify(userInfo))
  };

  onUserStatusChanged(userOnlineStatus: OnlineStatus): void{
    console.error('==========================onUserStatusChanged',JSON.stringify(userOnlineStatus))
  };

  onUserCommandAdd(userCommand: string): void{
    console.error('==========================onUserCommandAdd',JSON.stringify(userCommand))
  };

  onUserCommandDelete(userCommand: string): void{
    console.error('==========================onUserCommandDelete',JSON.stringify(userCommand))
  };

  onUserCommandUpdate(userCommand: string): void{
    console.error('==========================onUserCommandUpdate',JSON.stringify(userCommand))
  };
}