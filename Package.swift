// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "MLCardDrawer",
	platforms: [
		.iOS(.v9)
	],
    products: [
        .library(
            name: "MLCardDrawer",
            targets: ["MLCardDrawer"])
	],
	targets: [
		.target(
			name: "MLCardDrawer",
			dependencies: [],
			path: "Source")
	],
	swiftLanguageVersions: [.v4.2]
)
