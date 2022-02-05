import Foundation

public protocol SeedDerivating {
    func seed(mnemonic: String, passphrase: String) throws -> Data
}
