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
        .package(url: "https://github.com/anquii/CryptoSwiftWrapper.git", .exact("1.4.3"))
    ],
    targets: [
        .target(name: "BIP39", dependencies: ["CryptoSwiftWrapper"]),
        .testTarget(name: "BIP39Tests", dependencies: ["BIP39"])
    ]
)
