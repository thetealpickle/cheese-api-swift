//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class Cheese: Codable {
    var id: UUIDString? // custom id needs to have its type specified, see model X10

    var createdAt: Date?
    var updatedAt: Date?

    var name: String


    init(_ name: String) {
        self.name = name

        self.id = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Class Extensions
// MARK: X10: Vapor Relationships
extension Cheese {
    var planets: Siblings<Cheese, Planet, PlanetCheesePivot> {
        return siblings()
    }
}

// MARK: X10: Vapor/Fluent Models
extension Cheese: Content {}
extension Cheese: Migration {}
extension Cheese: Parameter {}

// MARK: X10: Model
extension Cheese: Model {
    typealias Database = MySQLDatabase

    typealias ID = UUIDString
    static let idKey: IDKey = \Cheese.id
}
