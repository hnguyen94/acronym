import Vapor
import Fluent

/// Controls basic CRUD operations on `Todo`s.
final class AcronymController {
    /// Returns a list of all `Todo`s.
    func index(_ req: Request) throws -> Future<[Acronym]> {
        Acronym.query(on: req).all()
    }

    func show(_ request: Request) throws -> Future<Acronym> {
        try request.parameters.next(Acronym.self)
    }

    func create(_ request: Request) throws -> Future<Acronym> {
        try request.content.decode(Acronym.self)
            .flatMap(to: Acronym.self) { acryonym in
                acryonym.save(on: request)
        }
    }

    func update(_ request: Request) throws -> Future<Acronym> {
        try flatMap(to: Acronym.self,
                    request.parameters.next(Acronym.self),
                    request.content.decode(Acronym.self)) { acryonym, updatedAcryonym in
                        acryonym.short = updatedAcryonym.short
                        acryonym.long = updatedAcryonym.long

                        return acryonym.save(on: request)
        }
    }

    func delete(_ request: Request) throws -> Future<HTTPStatus> {
        try request.parameters.next(Acronym.self)
            .delete(on: request)
            .transform(to: .ok)
    }
}
