# BIP39

An implementation of [BIP39](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) in Swift.

## Platforms
- macOS 10.15+
- iOS 13+

## Installation

### Swift Package Manager

Add the following line to your `Package.swift` file:
```swift
.package(url: "https://github.com/anquii/BIP39.git", from: "1.0.0")
```

## Usage

```swift
import BIP39
```
```swift
let entropyGenerator: EntropyGenerating = EntropyGenerator()
let wordListProvider: WordListProviding = EnglishWordListProvider()
let mnemonicConstructor: MnemonicConstructing = MnemonicConstructor()
let seedDerivator: SeedDerivating = SeedDerivator()
```
```swift
do {
    let entropy = try entropyGenerator.entropy(security: .strongest)
    let mnemonic = mnemonicConstructor.mnemonic(entropy: entropy, wordList: wordListProvider.wordList)
    let seed = try seedDerivator.seed(mnemonic: mnemonic, passphrase: "")
} catch {
    // Handle error
}
```
