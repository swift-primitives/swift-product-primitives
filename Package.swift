// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-product",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "Product",
            targets: ["Product"]
        ),
        .library(
            name: "Product Standard Library Integration",
            targets: ["Product Standard Library Integration"]
        ),
        .library(
            name: "Product Apple Foundation Integration",
            targets: ["Product Apple Foundation Integration"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Product",
            dependencies: []
        ),
        .target(
            name: "Product Standard Library Integration",
            dependencies: ["Product"]
        ),
        .target(
            name: "Product Apple Foundation Integration",
            dependencies: [
                "Product",
                "Product Standard Library Integration",
            ]
        ),
        .testTarget(
            name: "Product Tests",
            dependencies: [
                "Product",
                "Product Standard Library Integration",
            ],
            path: "Tests/Product Tests"
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("Lifetimes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
