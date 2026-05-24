// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShortcutMac",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "ShortcutMac",
            path: "Sources/ShortcutMac",
            linkerSettings: [.linkedFramework("Carbon")]
        )
    ]
)
