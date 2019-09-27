//
//  Category.swift
//  App
//
//  Created by Hoang Nguyen on 27.09.19.
//

import Vapor
import FluentSQLite

final class Category: Content {
    var id: Int?
    var name: String

    init(name: String) {
        self.name = name
    }
}

extension Category {
    var acronyms: Siblings<Category, Acronym, AcronymCategoryPivot> {
        siblings()
    }
}

extension Category: SQLiteModel {}
extension Category: Migration {}
extension Category: Parameter {}



