export interface IConnListener {
  onConnecting(): void;

  onConnectSuccess(): void;

  onConnectFailed(errCode: number, errMsg: string): void;

  onKickedOffline(): void;

  onUserTokenExpired(): void;

  onUserTokenInvalid(errMsg: string): void;
}
