//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import App
import FluentMySQL
import Vapor

// Extension to ease setup/reset and request/respond functionality
extension Application {
    
    // MARK: Setup/Reset Class Methods
    static func testable(envArgs: [String]? = nil) throws -> Application {
        
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        
        if let environmentArgs = envArgs {
            env.arguments = environmentArgs
        }
        
        try App.configure(&config, &env, &services)
        let app = try Application(config: config,
                                  environment: env,
                                  services: services)
        
        try App.boot(app)
        return app
    }
    
    static func reset() throws {
        let revertEnv = ["vapor", "revert", "--all", "-y"] // revert arguments
        try Application.testable(envArgs: revertEnv)
            .asyncRun()
            .wait()
        
        let migrateEnv = ["vapor", "migrate", "-y"] //migrate arguments
        try Application.testable(envArgs: migrateEnv)
            .asyncRun()
            .wait()
    }
    
    // MARK: Request Methods
    func sendRequest<Type: Content>(to path: String,
                           method: HTTPMethod,
                           headers: HTTPHeaders = .init(),
                           body: Type? = nil) throws -> Response {
        
        let responder = try self.make(Responder.self)
        
        let request = HTTPRequest(method: method,
                                  url: URL(string: path)!,
                                  headers: headers)
        let wrappedRequest = Request(http: request, using: self)
        
        if let body = body {
            try wrappedRequest.content.encode(body)
        }
        
        return try responder.respond(to: wrappedRequest).wait()
    }
    
    func sendRequest(to path: String,
                                    method: HTTPMethod,
                                    headers: HTTPHeaders = .init()) throws -> Response {
        
        let emptyContent: EmptyContent? = nil
        return try sendRequest(
            to: path,
            method: method,
            headers: headers,
            body: emptyContent
        )
    }
    
    func sendRequest<Type: Content>(to path: String,
                                    method: HTTPMethod,
                                    headers: HTTPHeaders = .init(),
                                    data: Type) throws {
        _ = try sendRequest(
            to: path,
            method: method,
            headers: headers,
            body: data
        )
    }
    
    // MARK: Respond Methods
    func getResponse<Data: Content, Type: Decodable>(to path: String,
                                                     method: HTTPMethod = .GET,
                                                     headers: HTTPHeaders = .init(),
                                                     data: Data? = nil,
                                                     decodeTo type: Type.Type) throws -> Type {
        let response = try self.sendRequest(to: path,
                                            method: method,
                                            headers: headers,
                                            body: data)
        
        return try response.content.decode(type).wait()
        
    }
    
    func getResponse<Type: Decodable>(to path: String,
                                      method: HTTPMethod = .GET,
                                      headers: HTTPHeaders = .init(),
                                      decodeTo type: Type.Type) throws -> Type {
        let emptyContent: EmptyContent? = nil
        
        return try self.getResponse(
            to: path,
            method: method,
            headers: headers,
            data: emptyContent,
            decodeTo: type)
    }
}



// MARK: - Empty Content Model
struct EmptyContent: Content {}


















