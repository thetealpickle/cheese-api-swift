//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Crypto
import FluentMySQL
import Vapor

/// Provides access to the database's protected routes
/// Enables creating other users post database reversions
final class AdminUser: Migration {
    typealias Database = MySQLDatabase

    /// Prepares the database, creating an admin user on the connection.
    /// - Parameter conn: MySQL connection for the database.
    static func prepare(on conn: MySQLConnection) -> Future<Void> {
        let hashedPassword = try? BCrypt.hash("password")

        guard let password = hashedPassword else {
            fatalError("🛑 Fatal Error 🛑 failed to create admin user")
        }

        let admin = User(name: "Admin",
                         username: "admin",
                         password: password)

        return admin.save(on: conn).transform(to: ())
    }

    static func revert(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        return .done(on: conn)
    }
}
