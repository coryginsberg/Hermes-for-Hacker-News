// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.
import PackageDescription

let package = Package(
  name: "Hermes",
  platforms: [
    .iOS(.v15),
    .macOS(.v14),
  ],
  dependencies: [
    // Prod Dependencies
    .package(
      url: "https://github.com/firebase/firebase-ios-sdk.git",
      .upToNextMajor(from: "8.10.0")
    ),
    .package(url: "https://github.com/will-lumley/FaviconFinder.git", from: "4.2.0"),
    // Dev Dependencies
    .package(url: "https://github.com/realm/SwiftLint.git", from: "0.37.0"),
    .package(url: "https://github.com/nicklockwood/SwiftFormat", from: "0.49.0"),
  ],
  targets: [
    .target(
      name: "Hermes",
      dependencies: [
        .product(name: "FirebaseAuth", package: "firebase-ios-sdk"),
        .product(name: "FirebaseDatabase", package: "firebase-ios-sdk"),
        .product(name: "FaviconFinder", package: "FaviconFinder"),
      ],
      path: "Hermes"
    )
  ]
)
