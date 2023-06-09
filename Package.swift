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
        .target(
            name: "InteractiveImageView",
            dependencies: [],
            swiftSettings: [
                .unsafeFlags(
                    [
                        "-Xfrontend", "-warn-long-expression-type-checking=100",
                        "-Xfrontend", "-warn-long-function-bodies=100",
                        "-Xfrontend", "-warn-concurrency",
                        "-Xfrontend", "-enable-actor-data-race-checks"
                    ],
                    .when(configuration: .debug)
                )
            ]
        ),
    ]
)
