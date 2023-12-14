import Foundation
import CryptoSwift

public protocol SeedDerivating {
    func seed(mnemonic: String) throws -> Data
    func seed(mnemonic: String, passphrase: String) throws -> Data
}

public struct SeedDerivator {
    public init() {}
}

// MARK: - SeedDerivating
extension SeedDerivator: SeedDerivating {
    public func seed(mnemonic: String) throws -> Data {
        try seed(mnemonic: mnemonic, passphrase: "")
    }

    public func seed(mnemonic: String, passphrase: String) throws -> Data {
        guard
            let password = mnemonic.decomposedStringWithCompatibilityMapping.data(using: .utf8)?.bytes,
            let salt = ("mnemonic" + passphrase).decomposedStringWithCompatibilityMapping.data(using: .utf8)?.bytes
        else {
            throw SeedDerivatorError.invalidInput
        }
        do {
            let keyDerivation = try PKCS5.PBKDF2(password: password, salt: salt, iterations: 2048, keyLength: 64, variant: .sha2(.sha512))
            return Data(try keyDerivation.calculate())
        } catch let error as PKCS5.PBKDF2.Error {
            throw SeedDerivatorError(error)
        }
    }
}
