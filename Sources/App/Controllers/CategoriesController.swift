//
//  CategoriesController.swift
//  App
//
//  Created by Hoang Nguyen on 27.09.19.
//

import Vapor

struct CategoriesController: RouteCollection {
    func boot(router: Router) throws {
        let categoriesRoute = router.grouped("api", "categories")

        categoriesRoute.get(use: index)
        categoriesRoute.post(Category.self, use: create)
        categoriesRoute.get(Category.parameter, use: show)
        categoriesRoute.get(Category.parameter, "acronyms", use: acronyms)
    }
}

// MARK: - CRUD

extension CategoriesController {
    func index(_ request: Request) throws -> Future<[Category]> {
        Category.query(on: request).all()
    }

    func create(_ request: Request, category: Category) throws -> Future<Category> {
        category.save(on: request)
    }

    func show(_ request: Request) throws -> Future<Category> {
        try request.parameters.next(Category.self)
    }

    func acronyms(_ request: Request) throws -> Future<[Acronym]> {
        try request.parameters.next(Category.self)
            .flatMap(to: [Acronym].self, { category in
                try category.acronyms.query(on: request).all()
            })
    }
}
