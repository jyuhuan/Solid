// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Solid",
    products: [
        .library(
            name: "Solid",
            targets: ["Solid"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.1.0")
    ],
    targets: [
        .target(
            name: "Solid"
        ),
        .testTarget(
            name: "SolidTests",
            dependencies: ["Solid"]
        ),
    ]
)
