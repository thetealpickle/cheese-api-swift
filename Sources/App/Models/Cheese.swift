//  B0RN BKLYN Inc.
//  PROJECT: Cheese API
//
//  Copyright © 2020 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

final class Cheese: Model {
    @ID(custom: "uuid", generatedBy: .user)
    var id: IDType?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?
    
    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Field("name")
    var name: String

    convenience init() {}
    
    init(_ name: String) {
        self.name = name

        self.id = UUID().uuidString
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}

// MARK: - Class Extensions
extension Cheese: Content {}
