export const redirect: (dir: string) => void;

export const registerMsgCallBack: (callback: (msgId: number, data: string) => void) => void;

export const callAPI: (apiKey: number, data: string) => string;

