//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class Cheese: Codable {
    var id: UUID?

    var fluentCreatedAt: String?
    var fluentUpdatedAt: String?

    var name: String
    var planetId: Planet.ID
    var userId: Planet.ID

    init(_ name: String, from planetId: Planet.ID, uploadedBy userId: User.ID) {
        self.name = name
        self.planetId = planetId
        self.userId = userId
    }
}

// MARK: - Class Extensions
// MARK: X10: Parent/Child/Sibling Relationships
extension Cheese {
    var user: Parent<Cheese, User> {
        return parent(\.userId)
    }

    var planet: Siblings<Cheese, Planet, CheesePlanetPivot> {
        return siblings()
    }
}

// MARK: X10: Vapor Models
extension Cheese: Content {}
extension Cheese: Migration {}
extension Cheese: MySQLUUIDModel {}
extension Cheese: Parameter {}
