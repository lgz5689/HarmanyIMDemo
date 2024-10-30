export function ToJson(data: object): string {
  return JSON.stringify(data);
}

export function parseJson<T>(data: string): T {
  return JSON.parse(data)
}