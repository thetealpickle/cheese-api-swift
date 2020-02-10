//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class User: Codable {
    var id: UUIDString?

    var createdAt: Date?
    var updatedAt: Date?

    var name: String
    var password: String
    var username: String
    
    init(name: String, username: String, password: String) {
        self.name = name
        self.password = password
        self.username = username
        
        self.id = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Class Extensions
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}

// MARK: X10: Vapor Relationships
extension User {
    var planets: Children<User, Planet> {
        return children(\.userID)
    }
}

// MARK: X10: Model
extension User: Model {
    typealias Database = MySQLDatabase

    typealias ID = UUIDString
    static let idKey: IDKey = \User.id
}
