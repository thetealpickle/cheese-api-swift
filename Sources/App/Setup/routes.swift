import Vapor
import Fluent

public func routes(_ router: Router) throws {
    
    // MARK: Register Controllers
    let acronymsController = AcronymController()
    try router.register(collection: acronymsController)
    
    let userController = UserController()
    try router.register(collection: userController)
    
    let categoriesController = CategoriesController()
    try router.register(collection: categoriesController)
}
