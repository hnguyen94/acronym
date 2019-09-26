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

    init(short: String, long: String) {
        self.short = short
        self.long = long
    }
}

//extension Acronym: Model {
//    typealias Database = SQLiteDatabase
//    typealias ID = Int
//    public static var idKey: IDKey = \.id
//}

extension Acronym: SQLiteModel {}
extension Acronym: Migration {}
extension Acronym: Parameter {}
