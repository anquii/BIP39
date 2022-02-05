import CryptoSwift

extension SeedDerivatorError {
    init(_ error: PKCS5.PBKDF2.Error) {
        switch error {
        case .invalidInput:
            self = .invalidInput
        case .derivedKeyTooLong:
            self = .derivedKeyTooLong
        @unknown default:
            self = .unknown
        }
    }
}
