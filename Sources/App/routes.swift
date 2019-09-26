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

    let acronymController = AcronymController()

    router.get("api", "acronyms", use: acronymController.index)

    router.get("api", "acronyms", Acronym.parameter, use: acronymController.show)

    router.post("api", "acronyms", use: acronymController.create)

    router.put("api", "acronyms", Acronym.parameter, use: acronymController.update)

    router.delete("api", "acronyms", Acronym.parameter, use: acronymController.delete)

    // Example of configuring a controller
//    let todoController = TodoController()
//    router.get("todos", use: todoController.index)
//    router.post("todos", use: todoController.create)
//    router.delete("todos", Todo.parameter, use: todoController.delete)

}
