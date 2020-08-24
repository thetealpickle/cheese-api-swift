//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

@testable import App
import FluentMySQL
import Vapor
import XCTest

final class UserTests: XCTestCase {
    
    let sampleName = "pistachio"
    let sampleUsername = "pistachioBread"
    let samplePassword = "bread"
    
    let userURI = "\(API_VERSION)/users"
    
    var app: Application!
    var connection: MySQLConnection!
    
    override func setUp() {
        try! Application.reset()
        app = try! Application.testable()
        connection = try! app.newConnection(to: .mysql).wait()
    }
    
    override func tearDown() {
        connection.close()
        try? app.syncShutdownGracefully()
    }
    
    
    func testUsersCanBeRetrievedFromAPI() throws {
        _ = try User.create(on: connection)
        _ = try User.create(on: connection)
        
        let response = try app.getResponse(to: userURI,
                                           decodeTo: [User].self)
        
        XCTAssertEqual(response.count, 2)
    }
    
    func testSingleUserCanBeRetrievedFromAPI() throws {
        let user = try User.create(name: sampleName,
                                   username: sampleUsername,
                                   password: samplePassword,
                                   on: connection)
        
        let response = try app.getResponse(
            to: "\(userURI)/\(user.id!)",
            decodeTo: User.self)
        
        XCTAssertNotNil(response.id)
        XCTAssertEqual(response.name, user.name)
        XCTAssertEqual(response.username, user.username)
        XCTAssertEqual(response.password, user.password)
    }
    
    func testUserPlanetsCanBeRetrieveFromAPI() throws {
        let user = try User.create(on: connection)
        
//        let planet = try Planet.create(userID: user.id!,
//                                       on: connection)
        
        
        
        let response = try app.getResponse(to: "\(userURI)/\(user.id!)/planets",
            decodeTo: [Planet].self)
        
        XCTAssertEqual(response.count, 1)
    }
}
