//
//  User.swift
//  App
//
//  Created by Hoang Nguyen on 27.09.19.
//

import Foundation
import Vapor
import FluentSQLite

final class User: Content {
    var id: UUID?
    var name: String
    var userName: String

    init(name: String, userName: String) {
        self.name = name
        self.userName = userName
    }
}

extension User {
    var acronyms: Children<User, Acronym> {
        children(\.userID)
    }
}

extension User: SQLiteUUIDModel {}
extension User: Migration {}
extension User: Parameter {}
