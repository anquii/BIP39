import Foundation

struct HexEncoder {
    private static let format = "%02x"

    static func encode(data: Data) -> String {
        data
            .map { String(format: Self.format, $0) }
            .joined()
    }
}
