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

    router.post(InfoData.self, at: "info") { req, data -> InfoResponse in
        return InfoResponse(request: data)
    }
    
    router.post("api", "acronyms") {req -> Future<Acronym> in
        return try req.content.decode(Acronym.self).flatMap(to: Acronym.self) { acronym in
            return acronym.save(on: req)
        }
    }
}

struct InfoData:Content {
    let name: String
    let birthday: Date
}

struct InfoResponse: Content {
    let request: InfoData
}
