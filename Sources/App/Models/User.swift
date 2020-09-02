//  B0RN BKLYN Inc.
//  PROJECT: Cheese API
//
//  Copyright © 2020 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

final class User: Model {
    @ID(custom: "uuid", generatedBy: .user)
    var id: IDType?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestampe(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Field(key: "name")
    var name: String
    
    @Field(key: "password")
    var password: String
    
    @Field(key: "username")
    var username: String
    
    convenience init() {}
    
    init(name: String, username: String, password: String) {
        self.name = name
        self.password = password
        self.username = username
        
        self.id = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Class Extensions
extension User: Content {}
