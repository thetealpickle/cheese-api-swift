import Vapor
import App
import FluentMySQL

extension Application {
    static func testable(envArgs: [String]? = nil) throws -> Application {
        var config = Config.default()
        var services = Services.default()
        var env = Environment.testing
        
        if let environmentArgs = envArgs {
            env.arguments = environmentArgs
        }
        
        try App.configure(&config, &env, &services)
        let app = try Application(config: config, environment: env, services: services)
        
        try App.boot(app)
        return app
    }
    
    static func reset() throws {
        // Reset the database for current test run
        let revertEnvArgs = ["vapor", "revert", "--all", "-y"]
        try Application.testable(envArgs: revertEnvArgs).asyncRun().wait()
        
        // Reset the database for current test run
        let migrateEnvArgs = ["vapor", "migrate", "-y"]
        try Application.testable(envArgs: migrateEnvArgs).asyncRun().wait()
    }
    
    func sendRequest<T> (
        to path: String,
        method: HTTPMethod,
        headers: HTTPHeaders = .init(),
        body: T? = nil) throws -> Response where T: Content {
        let responder = try self.make(Responder.self)
        
        let request = HTTPRequest(method: method, url: URL(string: path)!, headers: headers)
        let wrappedRequest = Request(http: request, using: self)
        
        if let body = body {
            try wrappedRequest.content.encode(body)
        }
        
        return try responder.respond(to: wrappedRequest).wait()
    }

    func sendRequest (
        to path: String,
        method: HTTPMethod,
        headers: HTTPHeaders = .init()
        ) throws -> Response {
        
        let emptyContent: EmptyContent? = nil
        
        return try sendRequest(to: path, method: method, headers: headers, body: emptyContent)
    }
    
    func sendRequest<T> (
        to path: String,
        method: HTTPMethod,
        headers: HTTPHeaders,
        data: T
        ) throws where T: Content {
        
        _ = try self.sendRequest(to: path, method: method, headers: headers, body: data)
    }
}

// Create Empty Content to send in place of nil for sending a request
struct EmptyContent: Content {}
