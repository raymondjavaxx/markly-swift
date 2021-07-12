// swift-tools-version:5.3
import PackageDescription

let package = Package(
  name: "Markly",
  defaultLocalization: "en",
  platforms: [
    .iOS(.v11),
    .macOS(.v10_15)
  ],
  products: [
    .library(
      name: "Markly",
      targets: ["Markly"]
    )
  ],
  targets: [
    .target(
      name: "Markly",
      dependencies: [],
      path: "Markly",
      exclude: ["Info.plist"]
    ),
    .testTarget(
      name: "MarklyTests",
      dependencies: ["Markly"],
      path: "MarklyTests",
      exclude: [
        "Info.plist"
      ],
      swiftSettings: [
        .define("SPM")
      ]
    )
  ]
)
