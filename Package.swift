// swift-tools-version:5.2
import PackageDescription

let package = Package(
    name: "CheeseVapor",
    products: [
        .library(name: "CheeseVapor", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.3.0"),
        
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0-rc"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-beta"),
        
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0-rc"),
    ],
    targets: [
        .target(name: "App",
                dependencies: [
                    .product(name: "Vapor", package: "vapor"),
                    .product(name: "Fluent", package: "fluent"),
                    .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                    .product(name: "JWT", package: "jwt")
            ]
        ),
        .target(name: "Run",
                dependencies: [
                    .target(name: "App")
            ]
        ),
        .testTarget(name: "AppTests",
                    dependencies: [
                        .target(name: "App")
            ]
        )
    ]
)

