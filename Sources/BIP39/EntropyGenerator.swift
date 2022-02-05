import Foundation

public protocol EntropyGenerating {
    func entropy(security: EntropySecurity) throws -> Data
}

public struct EntropyGenerator {
    private static let bitsInByte = 8

    public init() {}
}

// MARK: - EntropyGenerating
extension EntropyGenerator: EntropyGenerating {
    public func entropy(security: EntropySecurity) throws -> Data {
        let entropyLength = Int(entropySecurity: security)
        var bytes = [UInt8](repeating: 0, count: entropyLength / Self.bitsInByte)

        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        if status == errSecSuccess {
            return Data(bytes)
        } else {
            throw EntropyGeneratorError.invalidEntropy
        }
    }
}
