import Foundation
import CryptoSwift

public protocol MnemonicConstructing {
    func mnemonic(entropy: Data, wordList: [String]) -> String
}

public struct MnemonicConstructor {
    private static let bitsInByte = 8
    private static let entropyEncodingMultipleInBits = 32
    private static let bitSegments = 11

    public init() {}
}

// MARK: - MnemonicConstructing
extension MnemonicConstructor: MnemonicConstructing {
    public func mnemonic(entropy: Data, wordList: [String]) -> String {
        let leadingZeros = String(repeating: "0", count: Self.bitsInByte)
        let entropyBits = entropy.flatMap { (leadingZeros + String($0, radix: 2)).suffix(Self.bitsInByte) }
        let hashBits = entropy.sha256().flatMap { (leadingZeros + String($0, radix: 2)).suffix(Self.bitsInByte) }

        let entropyLength = entropy.count * Self.bitsInByte
        let checksumLength = entropyLength / Self.entropyEncodingMultipleInBits
        let checksumBits = hashBits.prefix(checksumLength)
        let concatenatedBits = entropyBits + checksumBits

        var words = [String]()
        for i in 0..<(concatenatedBits.count / Self.bitSegments) {
            let startIndex = concatenatedBits.index(concatenatedBits.startIndex, offsetBy: i * Self.bitSegments)
            let endIndex = concatenatedBits.index(startIndex, offsetBy: Self.bitSegments)
            let wordIndex = Int(strtoul(String(concatenatedBits[startIndex..<endIndex]), nil, 2))
            words.append(wordList[wordIndex])
        }

        return words.joined(separator: " ")
    }
}
