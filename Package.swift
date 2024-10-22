// swift-tools-version:5.10

import PackageDescription

let package = Package(
    name: "TONSwift",
    platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "TONSwift", targets: ["TONSwift"]),
    ],
    dependencies: [
        .package(url: "https://github.com/attaswift/BigInt.git", from: "5.4.1"),
        .package(url: "https://github.com/bitmark-inc/tweetnacl-swiftwrap.git", from: "1.1.0"),
        .package(url: "https://github.com/jedisct1/swift-sodium", from: "0.9.1"),
        .package(url: "https://github.com/nicklockwood/SwiftFormat.git", from: "0.54.6"),
    ],
    targets: [
        .target(
            name: "TONSwift",
            dependencies: [
                "BigInt",
                .product(name: "TweetNacl", package: "tweetnacl-swiftwrap"),
                .product(name: "Sodium", package: "swift-sodium"),
            ]
        ),
        .testTarget(
            name: "TONSwiftTests",
            dependencies: [
                .target(name: "TONSwift"),
                "BigInt",
                .product(name: "TweetNacl", package: "tweetnacl-swiftwrap"),
            ]
        ),
    ]
)
