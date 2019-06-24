import Vapor

struct UserController: RouteCollection {
    func boot(router: Router) throws {
        
        let userRouter = router.grouped("api", "users")
        
        userRouter.post(User.self, use: createHandler)
        
        userRouter.get(use: getAllHandler)
        userRouter.get(User.parameter, use: getHandler)
        userRouter.get(User.parameter, "acronyms", use: getAcronymsHandler)
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
    
    func getAcronymsHandler(_ req: Request) throws -> Future<[Acronym]> {
        return try req.parameters.next(User.self).flatMap(to: [Acronym].self) { user in
            try user.acronyms.query(on: req).all()
        }
    }
}
