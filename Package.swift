// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "DefaultsWrapper",
    products: [
        .library(name: "DefaultsWrapper", targets: ["DefaultsWrapper"]),
    ],
    dependencies: [ ],
    targets: [
        .target(name: "DefaultsWrapper", dependencies: []),
        .testTarget(name: "DefaultsWrapperTests", dependencies: ["DefaultsWrapper"]),
    ]
)
