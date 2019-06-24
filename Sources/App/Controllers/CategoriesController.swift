import Vapor

struct CategoriesController: RouteCollection {
    func boot(router: Router) throws {
        
        let categoriesRoutes = router.grouped("api", "categories")
        
        categoriesRoutes.post(Category.self, use: createHandler)
        
        categoriesRoutes.get(use: getAllHandler)
        categoriesRoutes.get(Category.parameter, use: getHandler)
    }
    
    func createHandler(_ req: Request, category: Category) throws -> Future<Category> {
        return category.save(on: req)
    }
    
    func getAllHandler(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }
    
    func getHandler(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self)
    }
}
