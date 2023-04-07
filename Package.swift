// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "InteractiveImageView",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "InteractiveImageView", targets: ["InteractiveImageView"]),
    ],
    targets: [
        .target(name: "InteractiveImageView", dependencies: []),
    ]
)
