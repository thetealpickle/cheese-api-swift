//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class Planet: Codable {
    var id: UUIDString?

    var name: String
    var userID: User.ID

    init(_ name: String, userID: User.ID) {
        self.name = name
        self.userID = userID
    }
}

// MARK: - Class Extensions
// MARK: X10: Vapor Relationships
extension Planet {
    var user: Parent<Planet, User> {
        return parent(\.userID)
    }
    
    var cheeses: Siblings<Planet, Cheese, PlanetCheesePivot> {
        return siblings()
    }
}

// MARK: X10: Vapor/Fluent Models
extension Planet: Parameter {}
extension Planet: Content {}

// MARK: X10: Migration
extension Planet: Migration {
    
    static func prepare(on connection: MySQLConnection) -> Future<Void> {
        return Database.create(self, on: connection) { builder in
            
            try addProperties(to: builder)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
    
}

// MARK: X10: Model
extension Planet: Model {
    typealias Database = MySQLDatabase

    typealias ID = UUIDString
    static let idKey: IDKey = \Planet.id
}
