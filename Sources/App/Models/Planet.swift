//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class Planet: Codable {
    var id: UUID?

    var name: String
    var userID: User.ID

    init(_ name: String, userID: User.ID) {
        self.name = name
        self.userID = userID
    }
}

// MARK: - Class Extensions
// MARK: X10: Parent/Child/Sibling Relationships
extension Planet {
    var user: Parent<Planet, User> {
        return parent(\.userID)
    }
}

// MARK: X10: Vapor Models
extension Planet: MySQLUUIDModel {}
extension Planet: Content {}
extension Planet: Migration {}
extension Planet: Parameter {}
