//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig()
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self)
    services.register(middlewares)
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    
    let databaseName: String
    let databasePort: Int
    
    if (env == .testing) {
        databaseName = "vapor-test"
        databasePort = 3307
    } else {
        databaseName = "vapor"
        databasePort = 3306
    }
    
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "localhost",
        port: databasePort,
        username: "vapor",
        password: "password",
        database: databaseName
    )
    
    let database = MySQLDatabase(config: mysqlConfig)
    databases.add(database: database, as: .mysql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    migrations.add(model: User.self, database: .mysql)
    migrations.add(model: Planet.self, database: .mysql)
    migrations.add(model: Cheese.self, database: .mysql)

    // pivots
    migrations.add(model: PlanetCheesePivot.self, database: .mysql)
    
    // admins
    migrations.add(migration: AdminUser.self, database: .mysql)
    
    services.register(migrations)

    // Configure Command
    var commandConfig = CommandConfig()
    commandConfig.useFluentCommands()
    services.register(commandConfig)
}
