import logger from "./utils/Logger";

export function DispatchMsg(msgId: number, data: string): void {
  logger.info(`handle msg -> ${msgId}:${data}`)
}