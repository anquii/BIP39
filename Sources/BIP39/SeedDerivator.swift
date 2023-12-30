import Foundation
import CommonCrypto

public protocol SeedDerivating {
    func seed(mnemonic: String) -> Data
    func seed(mnemonic: String, passphrase: String) -> Data
}

public struct SeedDerivator: SeedDerivating {
    public func seed(mnemonic: String) -> Data {
        seed(mnemonic: mnemonic, passphrase: "")
    }
    public func seed(mnemonic: String, passphrase: String) -> Data {
        let password = mnemonic.decomposedStringWithCompatibilityMapping.data(using: .utf8)!.map(CChar.init)
        let salt = ("mnemonic" + passphrase).decomposedStringWithCompatibilityMapping.data(using: .utf8)!.map { $0 }
        var bytes = [UInt8](repeating: 0, count: 64)
        guard CCKeyDerivationPBKDF(
            CCPBKDFAlgorithm(kCCPBKDF2),
            password,
            password.count,
            salt,
            salt.count,
            CCPBKDFAlgorithm(kCCPRFHmacAlgSHA512),
            2048,
            &bytes,
            bytes.count
        ) == kCCSuccess else {
            preconditionFailure()
        }
        return Data(bytes)
    }
    public init() {}
}
