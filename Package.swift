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
    targets: [
        .target(name: "ImageScroll", dependencies: []),
    ]
)
