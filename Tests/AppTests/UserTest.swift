@testable import App
import Vapor
import XCTest
import FluentMySQL

final class UserTests: XCTestCase {
    
    // MARK: Test User Retrieval
    func testUsersCanBeRetrievedFromAPI() throws {
        
        // Reset the database for current test run
        let revertEnvArgs = ["vapor", "revert", "--all", "-y"]
        var revertConfig = Config.default()
        var revertServices = Services.default()
        var revertEnv = Environment.testing
        
        revertEnv.arguments = revertEnvArgs
        
        try App.configure(&revertConfig, &revertEnv, &revertServices)
        let revertApp = try Application(
            config: revertConfig,
            environment: revertEnv,
            services: revertServices
        )
        
        try App.boot(revertApp)
        try revertApp.asyncRun().wait()
        
        // Reset the database for current test run
        let migrateEnvArgs = ["vapor", "migrate", "-y"]
        var migrateConfig = Config.default()
        var migrateServices = Services.default()
        var migrateEnv = Environment.testing
        
        migrateEnv.arguments = migrateEnvArgs
        
        try App.configure(&migrateConfig, &migrateEnv, &migrateServices)
        let migrateApp = try Application(
            config: migrateConfig,
            environment: migrateEnv,
            services: migrateServices
        )
        
        try App.boot(migrateApp)
        try migrateApp.asyncRun().wait()
        
        
        let conn = try migrateApp.newConnection(to: .mysql).wait()
        
        let expectedName = "Cucumber"
        let expectedUsername = "cucumberPickle"
        
        let user = User(name: expectedName, username: expectedUsername)
        let savedUser = try user.save(on: conn).wait()
        _ = try User(name: "Bob", username: "bobbiePizza").save(on: conn).wait()
        
        let responder = try migrateApp.make(Responder.self)
        
        let request = HTTPRequest(method: .GET, url: URL(string: "/api/users")!)
        let wrappedRequest = Request(http: request, using: migrateApp)
        
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
