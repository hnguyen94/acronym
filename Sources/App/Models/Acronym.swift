//
//  Acronym.swift
//  App
//
//  Created by Hoang Nguyen on 25.09.19.
//

import Vapor
import FluentSQLite

final class Acronym: Content {
    var id: Int?
    var short: String
    var long: String
    var userID: User.ID

    init(short: String, long: String, userID: User.ID) {
        self.short = short
        self.long = long
        self.userID = userID
    }
}

extension Acronym {
    var user: Parent<Acronym, User> {
        parent(\.userID)
    }
}

extension Acronym: SQLiteModel {}
extension Acronym: Migration {}
extension Acronym: Parameter {}
