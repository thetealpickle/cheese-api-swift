//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class User: Codable {
    var id: UUID?

    var fluentCreatedAt: Date?
    var fluentUpdatedAt: Date?

    var name: String
    var password: String
    var username: String
    
    init(name: String, username: String, password: String) {
        self.name = name
        self.password = password
        self.username = username
    }
}

// MARK: - Class Extensions
// MARK: X10: Vapor Relationships
extension User {
    var planets: Children<User, Planet> {
        return children(\.userID)
    }
}

// MARK: X10: Vapor Models
extension User: MySQLUUIDModel {}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
