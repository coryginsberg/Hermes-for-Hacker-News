// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "HackerNewsApp",
  platforms: [
    .iOS(.v15),
  ],
  dependencies: [
    .package(
      name: "Firebase",
      url: "https://github.com/firebase/firebase-ios-sdk.git",
      .upToNextMajor(from: "8.10.0")
    ),
    .package(url: "https://github.com/will-lumley/FaviconFinder.git", from: "4.2.0"),
  ],
  targets: [
    .target(
      name: "HackerNewsApp",
      dependencies: [
        .product(name: "FirebaseAuth", package: "Firebase"),
        .product(name: "FirebaseDatabase", package: "Firebase"),
        .product(name: "FaviconFinder", package: "FaviconFinder"),
      ],
      path: "HackerNewsApp"
    ),
  ]
)
