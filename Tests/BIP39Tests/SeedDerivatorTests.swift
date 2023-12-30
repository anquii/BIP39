import XCTest
import Foundation
import BinaryExtensions
import BIP39

final class SeedDerivatorTests: XCTestCase {
    private var testVectors: [TestVector]!

    override func setUpWithError() throws {
        testVectors = try JSONDecoder().decode([TestVector].self, from: testVectorData)
    }

    private func sut() -> SeedDerivator {
        .init()
    }

    func testGivenVectors_WhenCount_ThenEqual24() {
        XCTAssertEqual(testVectors.count, 24)
    }

    func testWhenGenerateSeed_AndCountBytes_ThenEqual64() {
        let seed = sut().seed(mnemonic: "")
        XCTAssertEqual(seed.count, 64)
    }

    func testGivenVectorMnemonic_AndValidPassphrase_WhenGenerateSeed_ThenEqualVectorSeed() {
        let sut = sut()
        let passphrase = "TREZOR"
        for testVector in testVectors {
            let seed = sut.seed(mnemonic: testVector.mnemonic, passphrase: passphrase)
            XCTAssertEqual(seed, Data(hexEncodedString: testVector.hexEncodedSeed, stripLeadingZeroes: false))
        }
    }

    func testGivenVectorMnemonic_AndInvalidPassphrase_WhenGenerateSeed_ThenNotEqualVectorSeed() {
        let sut = sut()
        let passphrase = "INVALID"
        for testVector in testVectors {
            let seed = sut.seed(mnemonic: testVector.mnemonic, passphrase: passphrase)
            XCTAssertNotEqual(seed, Data(hexEncodedString: testVector.hexEncodedSeed, stripLeadingZeroes: false))
        }
    }
}
