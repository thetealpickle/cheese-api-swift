//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

public func routes(_ router: Router) throws {
    
    // MARK: Register Controllers
    let userController = UserController()
    try router.register(collection: userController)
}
