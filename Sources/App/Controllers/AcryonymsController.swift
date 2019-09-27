import Vapor
import Fluent

// MARK: - Routes
final class AcronymsController: RouteCollection {
    func boot(router: Router) throws {
        let acronymRoutes = router.grouped("api", "acronyms")

        acronymRoutes.get(use: index)
        acronymRoutes.get(Acronym.parameter, use: show)
        acronymRoutes.post(Acronym.self, use: create)
        acronymRoutes.put(Acronym.parameter, use: update)
        acronymRoutes.delete(Acronym.parameter, use: delete)
        acronymRoutes.get("search", use: search)
        acronymRoutes.get("first", use: first)
        acronymRoutes.get("sort", use: sort)
        acronymRoutes.get(Acronym.parameter, "user", use: user)
    }
}

// MARK: - CRUD
extension AcronymsController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Acronym]> {
        Acronym.query(on: req).all()
    }

    func show(_ request: Request) throws -> Future<Acronym> {
        try request.parameters.next(Acronym.self)
    }

    func create(_ request: Request, acronym: Acronym) throws -> Future<Acronym> {
        acronym.save(on: request)
    }

    func update(_ request: Request) throws -> Future<Acronym> {
        try flatMap(to: Acronym.self,
                    request.parameters.next(Acronym.self),
                    request.content.decode(Acronym.self)) { acryonym, updatedAcryonym in
                        acryonym.short = updatedAcryonym.short
                        acryonym.long = updatedAcryonym.long
                        acryonym.userID = updatedAcryonym.userID

                        return acryonym.save(on: request)
        }
    }

    func delete(_ request: Request) throws -> Future<HTTPStatus> {
        try request.parameters.next(Acronym.self)
            .delete(on: request)
            .transform(to: .ok)
    }

    func search(_ request: Request) throws -> Future<[Acronym]> {
        guard let searchTerm = request.query[String.self, at: "term"] else {
            throw Abort(.badRequest)
        }

        return Acronym.query(on: request).group(.or) { or in
            or.filter(\.short == searchTerm)
            or.filter(\.long == searchTerm)
        }.all()
    }

    func first(_ request: Request) throws -> Future<Acronym> {
        Acronym.query(on: request)
            .first()
            .unwrap(or: Abort(.notFound))
    }

    func sort(_ request: Request) throws -> Future<[Acronym]> {
        Acronym.query(on: request)
            .sort(\.short, .ascending)
            .all()
    }

    func user(_ request: Request) throws -> Future<User> {
        try request
            .parameters.next(Acronym.self)
            .flatMap(to: User.self) { acronym in
                acronym.user.get(on: request)
        }
    }
}
