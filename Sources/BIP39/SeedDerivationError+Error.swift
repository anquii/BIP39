import CryptoSwift

extension SeedDerivationError {
    init(error: PKCS5.PBKDF2.Error) {
        switch error {
        case .invalidInput:
            self = .invalidInput
        case .derivedKeyTooLong:
            self = .derivedKeyTooLong
        }
    }
}
