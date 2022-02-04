import Foundation
import CryptoSwift

public struct SeedDerivator: SeedProviding {
    private static let saltConstant = "mnemonic"
    private static let iterations = 2048
    private static let keyLength = 64
    private static let variant = HMAC.Variant.sha2(.sha512)

    public func seed(password: String, passphrase: String = "") throws -> Data {
        do {
            let keyDerivation = try PKCS5.PBKDF2(
                password: self.password(password),
                salt: salt(passphrase: passphrase),
                iterations: Self.iterations,
                keyLength: Self.keyLength,
                variant: Self.variant
            )
            return Data(
                try keyDerivation.calculate()
            )
        } catch let error as PKCS5.PBKDF2.Error {
            throw SeedDerivationError(error: error)
        }
    }
}

// MARK: - Helpers
fileprivate extension SeedDerivator {
    func password(_ password: String) -> Array<UInt8> {
        password.utf8.map({ $0 })
    }

    func salt(passphrase: String) -> Array<UInt8> {
        (Self.saltConstant + passphrase).utf8.map({ $0 })
    }
}
