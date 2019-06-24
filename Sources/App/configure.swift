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
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

    // Configure a SQLite database
//    let sqlite = try SQLiteDatabase(storage: .memory)
//    let sqlite = try SQLiteDatabase(storage: .file(path: "db.sqlite"))

    let mysqlConfig = MySQLDatabaseConfig(
        hostname: "localhost",
        username: "vapor",
        password: "password",
        database: "vapor"
    )
    
    
    // Register the configured SQLite database to the database config.
    var databases = DatabasesConfig()
    let database = MySQLDatabase(config: mysqlConfig)
    databases.add(database: database, as: .mysql)
    services.register(databases)

    // Configure migrations
    var migrations = MigrationConfig()
    
    // user migration needs to be on top since there is a foreign link between the acronyms table and the user table
    // can not create link to a non existing table
    migrations.add(model: User.self, database: .mysql)
    migrations.add(model: Acronym.self, database: .mysql)
    migrations.add(model: Category.self, database: .mysql)
    services.register(migrations)
}
