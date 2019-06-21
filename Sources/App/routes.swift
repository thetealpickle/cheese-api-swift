import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }
    
    // Adding a test route
    router.get("cheese", String.parameter) {req -> String in
        
        let name = try req.parameters.next(String.self)
        
        return "Cheesy fun time with \(name)"
    }

    router.post(InfoData.self, at: "info") { req, data -> String in
        return "Hello \(data.name)"
    }
    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)
}

struct InfoData:Content {
    let name: String
}
