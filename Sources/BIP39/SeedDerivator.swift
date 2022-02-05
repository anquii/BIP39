import Foundation
import CryptoSwift

public struct SeedDerivator: SeedDerivating {
    private static let saltConstant = "mnemonic"
    private static let iterations = 2048
    private static let keyLength = 64
    private static let variant = HMAC.Variant.sha2(.sha512)

    public func seed(mnemonic: String, passphrase: String = "") throws -> Data {
        do {
            let keyDerivation = try PKCS5.PBKDF2(
                password: password(mnemonic: mnemonic),
                salt: salt(passphrase: passphrase),
                iterations: Self.iterations,
                keyLength: Self.keyLength,
                variant: Self.variant
            )
            return Data(
                try keyDerivation.calculate()
            )
        } catch let error as PKCS5.PBKDF2.Error {
            throw SeedDerivatorError(error)
        }
    }
}

// MARK: - Helpers
fileprivate extension SeedDerivator {
    func password(mnemonic: String) -> Array<UInt8> {
        mnemonic.utf8.map({ $0 })
    }

    func salt(passphrase: String) -> Array<UInt8> {
        (Self.saltConstant + passphrase).utf8.map({ $0 })
    }
}
