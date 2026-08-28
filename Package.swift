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
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/swift-molecules/swift-comparison.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-equation.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/swift-molecules/swift-hash.git",
            branch: "main"
        ),
    ],
    targets: [
        .target(
            name: "Product",
            dependencies: [
                .product(name: "Comparison", package: "swift-comparison"),
                .product(name: "Equation", package: "swift-equation"),
                .product(name: "Hash", package: "swift-hash"),
            ]
        ),
        .testTarget(
            name: "Product Tests",
            dependencies: [
                .product(name: "Equation", package: "swift-equation"),
                "Product",
                .product(
                    name: "Comparison Standard Library Integration",
                    package: "swift-comparison"
                ),
                .product(
                    name: "Equation Standard Library Integration",
                    package: "swift-equation"
                ),
                .product(
                    name: "Hash Standard Library Integration",
                    package: "swift-hash"
                ),
            ]
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
