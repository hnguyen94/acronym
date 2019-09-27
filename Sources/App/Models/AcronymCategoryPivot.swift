//
//  AcronymCategoryPivot.swift
//  App
//
//  Created by Hoang Nguyen on 27.09.19.
//

import FluentSQLite
import Foundation

final class AcronymCategoryPivot: SQLiteUUIDPivot {
    typealias Left = Acronym
    typealias Right = Category

    var id: UUID?
    var acronymID: Acronym.ID
    var categoryID: Category.ID

    static let leftIDKey: LeftIDKey = \.acronymID
    static let rightIDKey: RightIDKey = \.categoryID

    init(_ acronym: Acronym, _ category: Category) throws {
        self.acronymID = try acronym.requireID()
        self.categoryID = try category.requireID()
    }
}

extension AcronymCategoryPivot: Migration {
    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
        Database.create(self, on: connection) { builder in
            try addProperties(to: builder)

            builder.reference(from: \.acronymID,
                              to: \Acronym.id,
                              onDelete: .cascade)

            builder.reference(from: \.categoryID,
                              to: \Category.id,
                              onDelete: .cascade)
        }
    }
}

extension AcronymCategoryPivot: ModifiablePivot {}
