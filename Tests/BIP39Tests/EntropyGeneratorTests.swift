import XCTest
import BIP39

final class EntropyGeneratorTests: XCTestCase {
    private func sut() -> EntropyGenerator {
        .init()
    }

    func testGivenWeakestEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual16() {
        let entropy = sut().entropy(security: .weakest)
        XCTAssertEqual(entropy.count, 16)
    }

    func testGivenWeakEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual20() {
        let entropy = sut().entropy(security: .`weak`)
        XCTAssertEqual(entropy.count, 20)
    }

    func testGivenMediumEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual24() {
        let entropy = sut().entropy(security: .medium)
        XCTAssertEqual(entropy.count, 24)
    }

    func testGivenStrongEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual28() {
        let entropy = sut().entropy(security: .strong)
        XCTAssertEqual(entropy.count, 28)
    }

    func testGivenStrongestEntropySecurity_WhenGenerateEntropy_AndCountBytes_ThenEqual32() {
        let entropy = sut().entropy(security: .strongest)
        XCTAssertEqual(entropy.count, 32)
    }
}
