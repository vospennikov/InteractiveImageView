// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ImageScroll",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "ImageScroll", targets: ["ImageScroll"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vospennikov/Gestures.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "ImageScroll",
            dependencies: [
                .product(name: "Gestures", package: "Gestures")
            ]
        ),
    ]
)
