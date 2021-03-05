// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CovidProject",
    platforms: [
        .macOS(.v10_12)
        ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/apple/swift-tools-support-core.git", from: "0.2.0")

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "CovidProject",
            dependencies: ["Alamofire", .product(name: "SwiftToolsSupport", package: "swift-tools-support-core")]),
        .testTarget(
            name: "CovidProjectTests",
            dependencies: ["CovidProject"]),
    ]
)
