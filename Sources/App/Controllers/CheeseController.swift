//  B0RN BKLYN Inc.
//  PROJECT: CheeseVapor
//
//  Copyright © 2019 JESSICA JEAN JOSEPH. All rights reserved.
//  MIT License

import Fluent
import Vapor

struct CheeseController: RouteCollection {
    func boot(router: Router) throws {
        let cheeseRoutes = router.grouped(API_VERSION , "cheeses")

        // create routes
        cheeseRoutes.post(use: createCheeseHandler)
        cheeseRoutes.post(Cheese.parameter, "planets", Planet.parameter,
                          use: addPlanetHandler)
        
        // retrieve routes
        cheeseRoutes.get( use: getAllCheesesHandler)

        cheeseRoutes.get(Cheese.parameter,
                   use: getSingleCheeseHandler)

        // update routes
        cheeseRoutes.put(Cheese.parameter,
                         use: updateCheeseHandler)

        // delete routes
        cheeseRoutes.delete(Cheese.parameter,
                            use: deleteCheeseHandler)
    }

    // MARK: - Route Handlers
    // MARK: Create Endpoint Handlers
    func createCheeseHandler(_ req: Request) throws -> Future<Cheese> {
        return try req
            .content
            .decode(Cheese.self)
            .flatMap(to: Cheese.self) { cheese in
                return cheese.save(on: req)
        }
    }
    
    func addPlanetHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try flatMap( to: HTTPStatus.self,
                            req.parameters.next(Cheese.self),
                            req.parameters.next(Planet.self)) { cheese, planet in
                                return cheese.planets
                                    .attach(planet, on: req)
                                    .transform(to: .created)
        }
    }

    // MARK: Retrieve Endpoint Handlers
    func getAllCheesesHandler(_ req: Request) throws -> Future<[Cheese]> {
        return Cheese.query(on: req).all()
    }

    func getSingleCheeseHandler(_ req: Request) throws -> Future<Cheese> {
        return try req.parameters.next(Cheese.self)
    }

    // MARK: Update Endpoint Handlers
    func updateCheeseHandler(_ req: Request) throws -> Future<Cheese> {
        return try flatMap(to: Cheese.self,
                           req.parameters.next(Cheese.self),
                           req.content.decode(Cheese.self)) { cheese, updatedCheese in

                            // update properties
                            cheese.name = updatedCheese.name

                            // update updatedAt date
                            cheese.updatedAt = Date()

                            return cheese.save(on: req)
        }
    }

    func deleteCheeseHandler(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Cheese.self)
            .delete(on: req)
            .transform(to: .noContent)
    }
}
