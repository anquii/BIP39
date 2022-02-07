import Foundation

public protocol MnemonicConstructing {
    func mnemonic(entropy: Data) -> String
}

public struct MnemonicConstructor {
    private static let bitsInByte = 8
    private static let entropyEncodingMultipleInBits = 32
    private static let bitSegments = 11

    private let wordListProvider: WordListProviding

    public init(wordListProvider: WordListProviding) {
        self.wordListProvider = wordListProvider
    }
}

// MARK: - MnemonicConstructing
extension MnemonicConstructor: MnemonicConstructing {
    public func mnemonic(entropy: Data) -> String {
        let hexEncodedPrefix = String(repeating: "0", count: Self.bitsInByte)
        let entropyBits = entropy.flatMap { (hexEncodedPrefix + String($0, radix: 2)).suffix(Self.bitsInByte) }
        let hashBits = entropy.sha256().flatMap { (hexEncodedPrefix + String($0, radix: 2)).suffix(Self.bitsInByte) }

        let entropyLength = entropy.count * Self.bitsInByte
        let checksumLength = entropyLength / Self.entropyEncodingMultipleInBits
        let checksumBits = hashBits.prefix(checksumLength)
        let concatenatedBits = entropyBits + checksumBits

        var words = [String]()
        let wordList = wordListProvider.wordList

        for i in 0..<(concatenatedBits.count / Self.bitSegments) {
            let startIndex = concatenatedBits.index(concatenatedBits.startIndex, offsetBy: i * Self.bitSegments)
            let endIndex = concatenatedBits.index(startIndex, offsetBy: Self.bitSegments)
            let wordIndex = Int(strtoul(String(concatenatedBits[startIndex..<endIndex]), nil, 2))
            words.append(wordList[wordIndex])
        }

        return words.joined(separator: " ")
    }
}
