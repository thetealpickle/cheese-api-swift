//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Vapor

final class CheesePlanetPivot: MySQLUUIDPivot  {
    var id: UUID?

    var cheeseId: Cheese.ID
    var planetId: Planet.ID

    typealias Left = Cheese
    typealias Right = Planet

    static let leftIDKey: LeftIDKey = \.cheeseId
    static let rightIDKey: RightIDKey = \.planetId

    init(_ cheese: Cheese, _ planet: Planet) throws {
        self.cheeseId = try cheese.requireID()
        self.planetId = try planet.requireID()
    }
}

// MARK: - Class Extensions
// MARK: X10: Vapor Models
extension CheesePlanetPivot: Migration {}
extension CheesePlanetPivot: ModifiablePivot {}
