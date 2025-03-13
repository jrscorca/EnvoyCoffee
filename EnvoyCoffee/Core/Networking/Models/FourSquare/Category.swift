//
//  Category.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct Category: Decodable, Hashable {
    let id: Int
    let name: String
    let icon: Icon?
    
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.id == rhs.id
    }
}
