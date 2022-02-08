# BIP39

[![Platform](https://img.shields.io/badge/Platforms-macOS%20%7C%20iOS-4E4E4E.svg?colorA=28a745)](#platforms) [![Swift Package Manager compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg?style=flat&colorA=28a745&&colorB=4E4E4E)](#swift-package-manager)

An implementation of [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) in Swift.

## Platforms
- macOS 10.15+
- iOS 13+

## Installation

### Swift Package Manager

Add the following line to your `Package.swift` file:
```swift
.package(url: "https://github.com/anquii/BIP39.git", from: "0.1.0")
```

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

This package is licensed under the terms of the MIT license. See the [LICENSE](LICENSE) file.
