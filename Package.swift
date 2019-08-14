// swift-tools-version:5.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GeocoderKit",
    platforms: [ .iOS(.v10) ],
    products: [
        .library(
            name: "GeocoderKit",
            targets: ["GeocoderKit"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "GeocoderKit",
            dependencies: []),
        .testTarget(
            name: "GeocoderKitTests",
            dependencies: ["GeocoderKit"]),
    ]
)
