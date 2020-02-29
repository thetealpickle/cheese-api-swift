//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

@testable import App
import FluentMySQL

// Extensions to ease model creation on database!
extension User {
    static func create(name: String = "Morty",
                       username: String = "rickmorty",
                       password: String = "password",
                       on connection: MySQLConnection) throws -> User {
        let user = User(name: name,
                        username: username,
                        password: password)
        return try user.create(on: connection).wait()
    }
}

extension Planet {
    static func create(name: String = "Rick",
                       userID: User.ID,
                       on connection: MySQLConnection) throws -> Planet {
        let planet = Planet(name,
                            userID: userID)
        return try planet.create(on: connection).wait()
    }
}


extension Cheese {
    static func create(name: String = "Jessica",
                       on connection: MySQLConnection) throws -> Cheese {
        let cheese = Cheese(name)
        return try cheese.create(on: connection).wait()
    }
}
