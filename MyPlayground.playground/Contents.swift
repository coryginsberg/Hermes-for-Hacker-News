
let source: [UInt8] = [0, 0, 0, 0x0e]
let bigEndianUInt32 = source.withUnsafeBytes { $0.load(as: UInt32.self) }
let value = CFByteOrderGetCurrent() == CFByteOrder(CFByteOrderLittleEndian.rawValue)
    ? UInt32(bigEndian: bigEndianUInt32)
    : bigEndianUInt32
print(value) // 14

