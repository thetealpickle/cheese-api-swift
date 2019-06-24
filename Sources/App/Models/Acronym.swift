import Vapor
import FluentMySQL

final class Acronym: Codable {
    var id: Int?
    var short: String
    var long: String
    var userID: User.ID
    
    init(short: String, long: String, userID: User.ID) {
        self.short = short
        self.long = long
        self.userID = userID
    }
}

extension Acronym {
    var user: Parent<Acronym, User> {
        return parent(\.userID)
    }
}

// MARK: Extending to SQLiteModel protocol
extension Acronym: MySQLModel {}

// MARK: save database model with migration
extension Acronym: Migration {}

// MARK: Content protocol
extension Acronym: Content {}

// MARK: Extending to Parameter protocol
// This allows the Acronym model to be passed as a route parameter
extension Acronym: Parameter {}
