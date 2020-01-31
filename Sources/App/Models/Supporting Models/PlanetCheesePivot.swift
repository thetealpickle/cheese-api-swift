//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import FluentMySQL
import Foundation

final class PlanetCheesePivot: MySQLUUIDPivot {
    var id: UUID?
    
    var planetID: Planet.ID
    var cheeseID: Cheese.ID
    
    typealias Left = Planet
    typealias Right = Cheese
    
    static let leftIDKey: LeftIDKey = \.planetID
    static let rightIDKey: RightIDKey = \.cheeseID
    
    init(_ planet: Planet, _ cheese: Cheese) throws {
        self.planetID = try planet.requireID()
        self.cheeseID = try cheese.requireID()
    }
}

extension PlanetCheesePivot: Migration {}
extension PlanetCheesePivot: ModifiablePivot {}
