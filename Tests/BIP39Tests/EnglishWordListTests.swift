import XCTest
@testable import BIP39

final class EnglishWordListTests: XCTestCase {
    private func sut() -> EnglishWordList {
        .init()
    }

    func testGivenEnglishWordList_WhenCountWords_ThenEqual2048() throws {
        XCTAssertEqual(sut().wordList.count, 2048)
    }
}
