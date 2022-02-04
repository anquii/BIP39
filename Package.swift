// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "BIP39",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(name: "BIP39", targets: ["BIP39"])
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMajor(from: "1.4.2"))
    ],
    targets: [
        .target(name: "BIP39", dependencies: ["CryptoSwift"]),
        .testTarget(name: "BIP39Tests", dependencies: ["BIP39"])
    ]
)
