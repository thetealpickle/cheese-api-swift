@testable import App
import Vapor
import XCTest
import FluentMySQL

final class UserTests: XCTestCase {
    
    // MARK: Test User Retrieval
    func testUsersCanBeRetrievedFromAPI() throws {
        var app = try Application.testable(envArgs: ["vapor", "migrate", "-y"])
        
        let conn = try app.newConnection(to: .mysql).wait()
        
        let expectedName = "Cucumber"
        let expectedUsername = "cucumberPickle"
        
        let user = User(name: expectedName, username: expectedUsername)
        let savedUser = try user.save(on: conn).wait()
        _ = try User(name: "Bob", username: "bobbiePizza").save(on: conn).wait()
        
        let responder = try app.make(Responder.self)
        
        let request = HTTPRequest(method: .GET, url: URL(string: "/api/users")!)
        let wrappedRequest = Request(http: request, using: app)
        
        let response = try responder.respond(to: wrappedRequest).wait()
        
        let data = response.http.body.data
        let users = try JSONDecoder().decode([User].self, from: data!)
        
        XCTAssertEqual(users.count, 2)
        XCTAssertEqual(users[0].name, expectedName)
        XCTAssertEqual(users[0].username, expectedUsername)
        XCTAssertEqual(users[0].id, savedUser.id)
        
        conn.close()
    }
}
