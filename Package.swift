// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HFKit",
    platforms: [.iOS(.v15), .macOS(.v11)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "HFKit",
            targets: ["HFKit"]),
    ],
    dependencies: [
        .package(path: "HFAuth"),
        .package(path: "HFCoreModel"),
        .package(path: "HFCoreUI"),
        .package(path: "HFNavigation")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "HFKit",
            dependencies: [
                "HFAuth",
                "HFCoreModel",
                "HFCoreUI",
                "HFNavigation"
            ]
        ),
        .testTarget(
            name: "HFKitTests",
            dependencies: ["HFKit"]),
    ]
)
