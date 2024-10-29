import { hilog } from '@kit.PerformanceAnalysisKit'

class Logger {
  private domain: number
  private tag: string

  constructor(domain: number, tag: string) {
    this.domain = domain
    this.tag = tag
  }

  public info(t: string) {
    hilog.info(this.domain, this.tag, "%{public}s", t)
  }

  public error(t: string) {
    hilog.error(this.domain, this.tag, "%s{public}s", t)
  }

  public debug(t: string) {
    hilog.debug(this.domain, this.tag, "%s{public}s", t)
  }

  public warn(t: string) {
    hilog.warn(this.domain, this.tag, "%s{public}s", t)
  }

  public fatal(t: string) {
    hilog.fatal(this.domain, this.tag, "%s{public}s", t)
  }
}

let logger = new Logger(0x494d, "[IM SDK]")

export default logger