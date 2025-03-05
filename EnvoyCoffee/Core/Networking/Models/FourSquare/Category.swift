//
//  Category.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct Category: Decodable {
    let id: Int
    let name: String
    let icon: Icon?
}
