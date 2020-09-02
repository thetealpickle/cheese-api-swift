//  B0RN BKLYN Inc.
//  PROJECT: Cheese API
//
//  Copyright © 2020 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import FluentMySQLDriver
import Vapor

/// Called before your application initializes.
public func configure(_ app: Application) throws {
    
    try routes(app)
    
    app.http.server.configuration.hostname = "localhost"
    
    app
        .databases
        .use(
            .mysql(configuration:
                MySQLConfiguration(url: Environment.get("DB_URL")!)!),
            as: .mysql,
            isDefault: true)
}
