//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class Cheese: Codable {
    var id: UUID?

    var createdAt: Date?
    var updatedAt: Date?

    var name: String


    init(_ name: String) {
        self.name = name
    }
}

// MARK: - Class Extensions
// MARK: X10: Vapor/Fluent Models
extension Cheese: Content {}
extension Cheese: Migration {}
extension Cheese: MySQLUUIDModel {}
extension Cheese: Parameter {}
