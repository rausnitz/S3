// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "S3",
    products: [
        .library(name: "S3Signer", targets: ["S3Signer"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0")
    ],
    targets: [
        .target(name: "S3Signer", dependencies: [
            "Vapor"
            ]
        )
    ]
)
