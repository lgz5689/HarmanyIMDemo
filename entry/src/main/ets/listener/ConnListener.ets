import { listener } from "imsdk";

export class ConnListener implements listener.ConnListener {
  onConnecting(): void {
    console.error('==========================onConnecting')
  }

  onConnectSuccess(): void {
    console.error('==========================onConnectSuccess')
  }

  onConnectFailed(errCode: number, errMsg: string): void {
    console.error('==========================onConnectFailed')
  }

  onKickedOffline(): void {
    console.error('==========================onKickedOffline')
  }

  onUserTokenExpired(): void {
    console.error('==========================onUserTokenExpired')
  }

  onUserTokenInvalid(errMsg: string): void {
    console.error('==========================onUserTokenInvalid')
  }
}