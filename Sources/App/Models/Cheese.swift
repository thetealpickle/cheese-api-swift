//
//  Cheese.swift
//  App
//
//  Created by Jessica Joseph on 12/21/19.
//

import Vapor

final class Cheese {
    var id: UUID?

    var fluentCreatedAt: String?
    var fluentUpdatedAt: String?

    var name: String
    var planetID: Planet.ID

    init(_ name: String, from planetID: Planet.ID) {
        
    }
}

