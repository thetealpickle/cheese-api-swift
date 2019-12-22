//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License


import Vapor
import Foundation
import FluentMySQL

final class User: Codable {
    var id: UUID?

    var fluentCreatedAt: Date?
    var fluentUpdatedAt: Date?

    var name: String
    var password: String
    var username: String
    
    init(name: String, username: String, password: String) {
        self.name = name
        self.password = password
        self.username = username
    }
}

extension User {
    var acronyms: Children<User, Acronym> {
        return children(\.userID)
    }
}

extension User: MySQLUUIDModel {}
extension User: Content {}
extension User: Migration {}
extension User: Parameter {}
