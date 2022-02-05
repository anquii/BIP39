import XCTest
@testable import BIP39

final class EntropyGeneratorTests: XCTestCase {
    private func sut() -> EntropyGenerator {
        .init()
    }

    func testGivenWeakestEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual16() throws {
        let security = EntropySecurity.weakest
        let entropy = try sut().entropy(security: security)
        XCTAssertEqual(entropy.count, 16)
    }

    func testGivenWeakEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual20() throws {
        let security = EntropySecurity.`weak`
        let entropy = try sut().entropy(security: security)
        XCTAssertEqual(entropy.count, 20)
    }

    func testGivenMediumEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual24() throws {
        let security = EntropySecurity.medium
        let entropy = try sut().entropy(security: security)
        XCTAssertEqual(entropy.count, 24)
    }

    func testGivenStrongEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual28() throws {
        let security = EntropySecurity.strong
        let entropy = try sut().entropy(security: security)
        XCTAssertEqual(entropy.count, 28)
    }

    func testGivenStrongestEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual32() throws {
        let security = EntropySecurity.strongest
        let entropy = try sut().entropy(security: security)
        XCTAssertEqual(entropy.count, 32)
    }
}
