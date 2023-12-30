import Foundation
import CryptoKit

public protocol MnemonicConstructing {
    func mnemonic(entropy: Data, wordList: [String]) -> String
}

public struct MnemonicConstructor: MnemonicConstructing {
    private static let radix = 2
    private static let bitSegments = 11
    public func mnemonic(entropy: Data, wordList: [String]) -> String {
        let leadingZeros = String(repeating: "0", count: UInt8.bitWidth)
        let entropyBits = entropy.flatMap { (leadingZeros + String($0, radix: Self.radix)).suffix(UInt8.bitWidth) }
        let hashBits = SHA256.hash(data: entropy).flatMap { (leadingZeros + String($0, radix: Self.radix)).suffix(UInt8.bitWidth) }
        let entropyLength = entropy.count * UInt8.bitWidth
        let checksumLength = entropyLength / UInt32.bitWidth
        let checksumBits = hashBits.prefix(checksumLength)
        let concatenatedBits = entropyBits + checksumBits
        var words = [String]()
        for i in 0..<(concatenatedBits.count / Self.bitSegments) {
            let startIndex = concatenatedBits.index(concatenatedBits.startIndex, offsetBy: i * Self.bitSegments)
            let endIndex = concatenatedBits.index(startIndex, offsetBy: Self.bitSegments)
            let wordIndex = Int(strtoul(String(concatenatedBits[startIndex..<endIndex]), nil, Int32(Self.radix)))
            words.append(wordList[wordIndex])
        }
        return words.joined(separator: " ")
    }
    public init() {}
}
