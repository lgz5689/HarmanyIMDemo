import imsdk from "libimsdk.so"

export function add(a: number, b: number) {
  return imsdk.add(a, b)
}