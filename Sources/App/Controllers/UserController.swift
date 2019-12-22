//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Vapor

struct UserController: RouteCollection {
    func boot(router: Router) throws {
        
        let userRouter = router.grouped("api", "users")
        
        userRouter.post(User.self, use: createHandler)
        
        userRouter.get(use: getAllHandler)
        userRouter.get(User.parameter, use: getHandler)
    }
    
    func createHandler(_ req: Request, user: User) throws -> Future<User> {
        return user.save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[User]> {
        return User.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(User.self)
    }
}
