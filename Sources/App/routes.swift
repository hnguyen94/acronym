import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return "It works!"
    }
    
    // Basic "Hello, world!" example
    router.get("hello", "vapor") { request in
        "Hello, vapor!"
    }


    // MARK: - Acronym

    try router.register(collection: AcronymsController())
    try router.register(collection: UsersController())
    try router.register(collection: CategoriesController())
}
