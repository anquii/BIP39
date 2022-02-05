import Foundation

public protocol MnemonicConstructing {
    func mnemonic(entropy: Data) -> String
}

public struct MnemonicConstructor {
    private let wordListProvider: WordListProviding

    public init(wordListProvider: WordListProviding) {
        self.wordListProvider = wordListProvider
    }
}

// MARK: - MnemonicConstructing
extension MnemonicConstructor: MnemonicConstructing {
    public func mnemonic(entropy: Data) -> String {
        ""
    }
}
