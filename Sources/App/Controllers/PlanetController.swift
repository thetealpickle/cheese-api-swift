//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

struct PlanetController: RouteCollection {
    func boot(router: Router) throws {
        let planetRoutes = router.grouped(API_VERSION, "planets")
        
        // create routes
        planetRoutes.post(use: createPlanetHandler)
        planetRoutes.post(Planet.parameter, "cheeses", Cheese.parameter,
                          use: addCheeseHandler)
        
        // retrieve routes
        planetRoutes.get(use: getAllPlanetsHandler)
        planetRoutes.get(Planet.parameter,
                         use: getPlanetHandler)
        planetRoutes.get(Planet.parameter, "user",
                         use: getUserHandler)
        planetRoutes.get(Planet.parameter, "cheeses",
                         use: getCheesesHandler)
        
        // update routes
        planetRoutes.put(Planet.parameter,
                         use: updatePlanetHandler)
        
        // delete routes
        planetRoutes.delete(Planet.parameter,
                            use: deletePlanetHandler)
    }
    
    //MARK: - Endpoint Handler Methods
    // MARK: Create Handlers
    func createPlanetHandler(_ req: Request) throws -> Future<Planet> {
        return try req
            .content
            .decode(Planet.self)
            .flatMap(to: Planet.self) { planet in
                return planet.save(on: req)
        }
    }
    
    func addCheeseHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap(to: HTTPStatus.self,
                           req.parameters.next(Planet.self),
                           req.parameters.next(Cheese.self)) { planet, cheese in
                            return planet.cheeses
                                .attach(cheese, on: req)
                                .transform(to: .created)
        }
    }
    
    // MARK: Retrieve Handlers
    func getAllPlanetsHandler(_ req: Request) throws -> Future<[Planet]> {
        return Planet.query(on: req).all()
    }
    
    func getPlanetHandler(_ req: Request) throws -> Future<Planet> {
        return try req.parameters.next(Planet.self)
    }
    
    func getUserHandler(_ req: Request) throws -> Future<User> {
        return try req.parameters.next(Planet.self)
            .flatMap(to: User.self) { planet in
                planet.user.get(on: req)
        }
    }
    
    func getCheesesHandler(_ req: Request) throws -> Future<[Cheese]> {
        return try req.parameters.next(Planet.self)
            .flatMap(to: [Cheese].self) { planet in
                try planet.cheeses.query(on: req).all()
        }
    }
    
    // MARK: Update Handlers
    func updatePlanetHandler(_ req: Request) throws -> Future<Planet> {
        return try flatMap(to: Planet.self,
                           req.parameters.next(Planet.self),
                           req.content.decode(Planet.self)) { planet, updated in
                            
                            planet.name = updated.name
                            planet.userID = updated.userID
                            
                            return planet.save(on: req)
        }
    }
    
    // MARK: Delete Handlers
    func deletePlanetHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Planet.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
