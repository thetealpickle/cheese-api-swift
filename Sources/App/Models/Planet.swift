//  B0RN BKLYN Inc.
//  PROJECT: Cheese API
//
//  Copyright © 2020 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

final class Planet: Model {
    
    @ID(custom: "uuid", generatedBy: .user)
    var id: IDType?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?
    
    @Field(key: "name")
    var name: String
    
    // FIXME: Fix user "parent" reference for vapor 4
    @Field(key: "")
    var userID: User.ID

    convenience init() {}
    
    init(_ name: String, userID: User.ID) {
        self.name = name
        self.userID = userID
    }
}

// MARK: - Class Extensions
extension Planet: Content {}
