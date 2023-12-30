import XCTest
import Foundation
import BinaryExtensions
import BIP39

final class MnemonicConstructorTests: XCTestCase {
    private let entropyGenerator = EntropyGenerator()
    private let wordListProvider = EnglishWordListProvider()
    private var testVectors: [TestVector]!

    override func setUpWithError() throws {
        testVectors = try JSONDecoder().decode([TestVector].self, from: testVectorData)
    }

    private func sut() -> MnemonicConstructor {
        .init()
    }

    func testGivenEntropyFromWeakestSecurity_WhenConstructMnemonic_AndCountWords_ThenEqual12() {
        let entropy = entropyGenerator.entropy(security: .weakest)
        let mnemonic = sut().mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
        XCTAssertEqual(numberOfWords(mnemonic: mnemonic), 12)
    }

    func testGivenEntropyFromWeakSecurity_WhenConstructMnemonic_AndCountWords_ThenEqual15() {
        let entropy = entropyGenerator.entropy(security: .`weak`)
        let mnemonic = sut().mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
        XCTAssertEqual(numberOfWords(mnemonic: mnemonic), 15)
    }

    func testGivenEntropyFromMediumSecurity_WhenConstructMnemonic_AndCountWords_ThenEqual18() {
        let entropy = entropyGenerator.entropy(security: .medium)
        let mnemonic = sut().mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
        XCTAssertEqual(numberOfWords(mnemonic: mnemonic), 18)
    }

    func testGivenEntropyFromStrongSecurity_WhenConstructMnemonic_AndCountWords_ThenEqual21() {
        let entropy = entropyGenerator.entropy(security: .strong)
        let mnemonic = sut().mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
        XCTAssertEqual(numberOfWords(mnemonic: mnemonic), 21)
    }

    func testGivenEntropyFromStrongestSecurity_WhenConstructMnemonic_AndCountWords_ThenEqual24() {
        let entropy = entropyGenerator.entropy(security: .strongest)
        let mnemonic = sut().mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
        XCTAssertEqual(numberOfWords(mnemonic: mnemonic), 24)
    }

    func testGivenVectorEntropy_WhenGenerateMnemonic_ThenMnemonicEqualVectorMnemonic() {
        let sut = sut()
        for testVector in testVectors {
            let entropy = Data(hexEncodedString: testVector.hexEncodedEntropy, stripLeadingZeroes: false)!
            let mnemonic = sut.mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
            XCTAssertEqual(mnemonic, testVector.mnemonic)
        }
    }
}

fileprivate extension MnemonicConstructorTests {
    func numberOfWords(mnemonic: String) -> Int {
        mnemonic.components(separatedBy: " ").count
    }
}
