//
//  UsersController.swift
//  App
//
//  Created by Hoang Nguyen on 27.09.19.
//

import Vapor

struct UsersController: RouteCollection {
    func boot(router: Router) throws {
        let usersRoute = router.grouped("api", "users")

        usersRoute.get(use: index)
        usersRoute.get(User.parameter, use: show)
        usersRoute.post(User.self, use: create)
        usersRoute.get(User.parameter, "acronyms", use: acronyms)
    }
}

// MARK: - CRUD

extension UsersController {
    func index(_ request: Request) throws -> Future<[User]> {
        User.query(on: request).all()
    }

    func show(_ request: Request) throws -> Future<User> {
        try request.parameters.next(User.self)
    }

    func create(_ request: Request, user: User) throws -> Future<User> {
        user.save(on: request)
    }

    func acronyms(_ request: Request) throws -> Future<[Acronym]> {
        try request
            .parameters.next(User.self)
            .flatMap(to: [Acronym].self) { user in
                try user.acronyms.query(on: request).all()
        }
    }
}
