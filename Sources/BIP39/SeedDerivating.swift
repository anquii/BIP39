import Foundation

public protocol SeedDerivating {
    func seed(password: String, passphrase: String) throws -> Data
}
