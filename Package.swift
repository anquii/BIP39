// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "BIP39",
    products: [
        .library(
            name: "BIP39",
            targets: ["BIP39"]
        ),
    ],
    targets: [
        .target(
            name: "BIP39"
        ),
        .testTarget(
            name: "BIP39Tests",
            dependencies: ["BIP39"]
        ),
    ]
)
