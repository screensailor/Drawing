// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Drawing",
    products: [
        .library(name: "Drawing", targets: ["Drawing"]),
    ],
    dependencies: [
        .package(url: "https://github.com/screensailor/Space.git", from: "0.1.0"),
        .package(url: "https://github.com/screensailor/Hope.git", from: "0.1.0"),
        .package(url: "https://github.com/ollieatkinson/NamedPoint.git", from: "0.1.0"),

    ],
    targets: [
        .target(name: "Drawing", dependencies: ["Space", "NamedPoint"]),
        .testTarget(name: "DrawingTests", dependencies: ["Drawing", "Hope"]),
    ]
)
