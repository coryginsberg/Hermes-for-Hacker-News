// swift-tools-version:5.2
import PackageDescription

let packageName = "HackerNewsApp"

let package = Package(
  name: "",
  platforms: [
    .iOS("16.0")
  ],
  products: [
    .library(name: packageName, targets: [packageName])
  ],
  dependencies: [
    .package(name: "Firebase",
           url: "https://github.com/firebase/firebase-ios-sdk.git",
           .upToNextMajor(from: "8.10.0")
           )
  ],
  targets: [
    .target(
      name: packageName,
      dependencies: [
        .product(name: "FirebaseAuth", package: "Firebase"),
        .product(name: "FirebaseDatabase", package: "Firebase")
      ],
      path: packageName
    )
  ]
)
