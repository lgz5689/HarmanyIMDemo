import { LogLevel, PlatformID } from "./Enum";

export interface IBoolValue {
  value: boolean;
}

export interface IStringValue {
  value: string;
}

export interface IIntValue {
  value: number;
}

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


export interface IMConfig {
  platformID: PlatformID;
  apiAddr: string;
  wsAddr: string;
  dataDir: string;
  logLevel: LogLevel;
  isLogStandardOutput: boolean;
  logFilePath: string;
  isExternalExtensions: boolean;
}