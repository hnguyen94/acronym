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
    try router.register(collection: acronymController)
    // MARK: Path
//    router.post(api, acronyms, use: acronymController.create)
//    router.put(api, acronyms, Acronym.parameter, use: acronymController.update)
//    router.delete(api, acronyms, Acronym.parameter, use: acronymController.delete)
//    router.get(api, acronyms, "search", use: acronymController.search)
//    router.get(api, acronyms, "first", use: acronymController.first)
//    router.get(api, acronyms, "sorted", use: acronymController.sort)
}
