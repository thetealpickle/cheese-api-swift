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
    var planetID: Planet.ID

    init(_ name: String, from planetID: Planet.ID) {
        self.name = name
        self.planetID = planetID
    }
}

// MARK: X10: Vapor Models
extension Cheese: Content {}
extension Cheese: Migration {}
extension Cheese: MySQLUUIDModel {}
extension Cheese: Parameter {}
