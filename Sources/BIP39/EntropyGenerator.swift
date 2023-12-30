import Foundation
import Security

public protocol EntropyGenerating {
    func entropy(security: EntropySecurity) -> Data
}

public struct EntropyGenerator: EntropyGenerating {
    public func entropy(security: EntropySecurity) -> Data {
        var bytes = [UInt8](repeating: 0, count: Int(entropySecurity: security) / UInt8.bitWidth)
        guard SecRandomCopyBytes(kSecRandomDefault, bytes.count, &bytes) == errSecSuccess else {
            preconditionFailure()
        }
        return Data(bytes)
    }
    public init() {}
}

fileprivate extension Int {
    init(entropySecurity: EntropySecurity) {
        switch entropySecurity {
        case .weakest:
            self = 128
        case .weak:
            self = 160
        case .medium:
            self = 192
        case .strong:
            self = 224
        case .strongest:
            self = 256
        }
    }
}
