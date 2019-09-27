// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "practice-vapor",
    products: [
        .library(name: "practice-vapor", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0-rc"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0-rc")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)


//let package = Package(
//    name: "pracktice-vapor",
//    dependencies: [
//        .package(url: "https://github.com/vapor/vapor.git",
//                 from: "3.0.0"),
//
//        // 1
//        .package(
//            url: "https://github.com/vapor/fluent-postgresql.git",
//            from: "1.0.0"),
//    ],
//    targets: [
//        // 2
//        .target(name: "App", dependencies: ["FluentPostgreSQL",
//                                            "Vapor"]),
//        .target(name: "Run", dependencies: ["App"]),
//        .testTarget(name: "AppTests", dependencies: ["App"]),
//    ]
//)
//
