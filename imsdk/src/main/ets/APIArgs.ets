export interface BaseArgs {
  operationId: string
}

export interface InitSDKArgs extends BaseArgs {
  config: string
}

export interface LoginArgs extends BaseArgs {
  uid: string
  token: string
}