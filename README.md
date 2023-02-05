# BIP39

[![Platform](https://img.shields.io/badge/Platforms-macOS%20%7C%20iOS-blue)](#platforms)
[![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-orange)](#swift-package-manager)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](https://github.com/anquii/BIP39/blob/main/LICENSE)

An implementation of [BIP-0039](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) in Swift.

## Platforms
- macOS 10.15+
- iOS 13+

## Installation

### Swift Package Manager

Add the following line to your `Package.swift` file:
```swift
.package(url: "https://github.com/anquii/BIP39.git", from: "1.0.0")
```
...or integrate with Xcode via `File -> Swift Packages -> Add Package Dependency...` using the URL of the repository.

## Usage

```swift
import BIP39

let entropyGenerator: EntropyGenerating = EntropyGenerator()
let entropy = try entropyGenerator.entropy(security: .strongest)
let wordListProvider: WordListProviding = EnglishWordListProvider()

let mnemonicConstructor: MnemonicConstructing = MnemonicConstructor()
let mnemonic = mnemonicConstructor.mnemonic(entropy: entropy, wordList: wordListProvider.wordList)

let seedDerivator: SeedDerivating = SeedDerivator()
let seed = try seedDerivator.seed(mnemonic: mnemonic, passphrase: "")
```

## License

`BIP39` is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file for more information.

## Acknowledgments

In developing `BIP39`, [KevinVitale](https://github.com/KevinVitale)'s [WalletKit](https://github.com/KevinVitale/WalletKit) has been used as a reference implementation. In addition, `BIP39` depends on [krzyzanowskim](https://github.com/krzyzanowskim)'s [CryptoSwift](https://github.com/krzyzanowskim/CryptoSwift) for crypto operations.

## Donations

If you've found this software useful, please consider making a small contribution to one of these crypto addresses:

```
XNAV: xNTYqoQDzsiB5Cff9Wpt65AgZxYkt1GFy7KwuDafqRU2bcAZqoZUW4Q9TZ9QRHSy8cPsM5ALkJasizJCmqSNP9CosxrF2RbKHuDz5uJVUBcKJfvnb3RZaWygr8Bhuqbpc3DsgfB3ayc
XMR: 49jzT7Amu9BCvc5q3PGiUzWXEBQTLQw68a2KvBFTMs7SHjeWgrSKgxs69ycFWQupyw9fpR6tdT8Hp5h3KksrBG9m4c8aXiG
BTC: bc1q7hehfmnq67x5k7vz0cnc75qyflkqtxe2avjkyw
ETH (ERC-20) & BNB (BEP-20): 0xe08e383B4042749dE5Df57d48c57A690DC322b8d
```
