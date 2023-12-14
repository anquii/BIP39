import XCTest
import BIP39

final class EnglishWordListProviderTests: XCTestCase {
    private func sut() -> EnglishWordListProvider {
        .init()
    }

    func testGivenEnglishWordList_WhenCountWords_ThenEqual2048() {
        XCTAssertEqual(sut().wordList.count, 2048)
    }
}
