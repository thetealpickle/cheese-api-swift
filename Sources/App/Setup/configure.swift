//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

/// Called before your application initializes.
public func configure(_ app: Application) throws {

    try routes(app)
}
