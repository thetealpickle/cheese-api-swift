//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Vapor

struct UserController: RouteCollection {
    func boot(router: Router) throws {
        
        let userRoutes = router.grouped(API_VERSION, "users")
        
        // create routes
        userRoutes.post(User.self, use: createHandler)
        
        // retrieve routes
        userRoutes.get(use: getAllHandler)
        userRoutes.get(User.parameter, use: getUserHandler)
        userRoutes.get(User.parameter, "planets",
                       use: getPlanetsHandler)
    }
    
    // MARK: - Endpoint Handler Methods
    // MARK: Create Handlers
    func createHandler(_ req: Request, user: User) throws -> Future<User> {
        return user.save(on: req)
    }
    
    // MARK: Retrieve Handlers
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getUserHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
    
    func getPlanetsHandler(_ req: Request) throws -> Future<[Planet]> {
        return try req.parameters.next(User.self)
            .flatMap(to: [Planet].self) { user in
                try user.planets.query(on: req).all()
        }
    }
}
