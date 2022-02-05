import XCTest
@testable import BIP39

final class SeedDerivatorTests: XCTestCase {
    private var testVectors: [TestVector]!

    override func setUpWithError() throws {
        testVectors = try JSONDecoder().decode([TestVector].self, from: testVectorData)
    }

    private func sut() -> SeedDerivator {
        .init()
    }

    func testGivenVectors_WhenCount_ThenEqual24() throws {
        XCTAssertEqual(testVectors.count, 24)
    }

    func testWhenGenerateSeed_AndCountBytes_ThenEqual64() throws {
        let seedData = try sut().seed(mnemonic: "")
        XCTAssertEqual(seedData.count, 64)
    }

    func testGivenVectorMnemonic_AndValidPassphrase_WhenGenerateSeed_ThenSeedEqualVectorSeed() throws {
        let sut = self.sut()
        let passphrase = "TREZOR"

        for testVector in testVectors {
            let seedData = try sut.seed(
                mnemonic: testVector.mnemonic,
                passphrase: passphrase
            )
            XCTAssertEqual(
                seedData,
                Data(hex: testVector.hexEncodedSeed)
            )
        }
    }

    func testGivenVectorMnemonic_AndInvalidPassphrase_WhenGenerateSeed_ThenSeedNotEqualVectorSeed() throws {
        let sut = self.sut()
        let passphrase = "INVALID"

        for testVector in testVectors {
            let seedData = try sut.seed(
                mnemonic: testVector.mnemonic,
                passphrase: passphrase
            )
            XCTAssertNotEqual(
                seedData,
                Data(hex: testVector.hexEncodedSeed)
            )
        }
    }
}
