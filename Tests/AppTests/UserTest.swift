@testable import App
import Vapor
import XCTest
import FluentMySQL

final class UserTests: XCTestCase {
    func testUsersCanBeRetrievedFromAPI() throws {
        let expectedName = "Cucumber"
        let expectedUsername = "cucumberPickle"
        
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        
        try App.configure(&config, &env, &services)
        let app = try Application(config: config, environment: env, services: services)
        try App.boot(app)
        
        let conn = try app.newConnection(to: .mysql).wait()
        
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
        XCTAssertEqual(users[1].name, expectedName)
        XCTAssertEqual(users[1].username, expectedUsername)
        XCTAssertEqual(users[1].id, savedUser.id)
        
        conn.close()
    }
    
}
