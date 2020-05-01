// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Drawing",
    products: [
        .library(name: "Drawing", targets: ["Drawing"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Space.git", .branch("master")),
        .package(url: "https://github.com/screensailor/Hope.git", .branch("master")),
    ],
    targets: [
        .target(name: "Drawing", dependencies: ["Space"]),
        .testTarget(name: "DrawingTests", dependencies: ["Drawing", "Hope"]),
    ]
)
