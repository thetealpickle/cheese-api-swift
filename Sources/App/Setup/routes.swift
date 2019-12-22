import Vapor
import Fluent

public func routes(_ router: Router) throws {
    
    // MARK: Register Controllers
    let userController = UserController()
    try router.register(collection: userController)
}
