import Foundation

public protocol SeedProviding {
    func seed(password: String, passphrase: String) throws -> Data
}
