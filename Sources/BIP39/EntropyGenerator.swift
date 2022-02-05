import Foundation

public protocol EntropyGenerating {
    func entropy(security: EntropySecurity) throws -> Data
}

public struct EntropyGenerator: EntropyGenerating {
    public func entropy(security: EntropySecurity) throws -> Data {
        let entropyLength = Int(entropySecurity: security)
        var bytes = [UInt8](repeating: 0, count: entropyLength / 8)

        let status = SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes)
        if status == errSecSuccess {
            return Data(bytes)
        } else {
            throw EntropyGeneratorError.invalidEntropy
        }
    }
}
