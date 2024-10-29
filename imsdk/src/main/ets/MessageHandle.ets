import logger from "./utils/Logger";

export function dispatchMsg(msgId: number, data: string): void {
  logger.info(`handle msg -> ${msgId}:${data}`)
}