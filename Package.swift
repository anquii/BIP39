// swift-tools-version:5.7

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
        .package(url: "https://github.com/anquii/BinaryExtensions.git", exact: "0.1.1"),
    ],
    targets: [
        .target(name: "BIP39"),
        .testTarget(name: "BIP39Tests", dependencies: ["BIP39", "BinaryExtensions"])
    ]
)
