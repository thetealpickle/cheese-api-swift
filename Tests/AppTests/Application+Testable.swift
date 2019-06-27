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
}
