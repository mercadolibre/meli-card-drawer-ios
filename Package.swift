// swift-tools-version:4.2

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
	swiftLanguageVersions: [.v4, .v4_2]
)
