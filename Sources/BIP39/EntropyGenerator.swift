import Foundation

public protocol EntropyGenerating {
    func entropy(security: EntropySecurity) throws -> Data
}

public struct EntropyGenerator {
    public init() {}
}

// MARK: - EntropyGenerating
extension EntropyGenerator: EntropyGenerating {
    public func entropy(security: EntropySecurity) throws -> Data {
        let entropyLength = Int(entropySecurity: security)
        var bytes = [UInt8](repeating: 0, count: entropyLength / 8)
        guard SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes) == errSecSuccess else {
            throw EntropyGeneratorError.invalidEntropy
        }
        return Data(bytes)
    }
}
