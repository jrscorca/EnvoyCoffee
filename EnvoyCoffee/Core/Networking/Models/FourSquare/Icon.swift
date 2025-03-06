//
//  Icon.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct Icon: Decodable {
    let prefix: String
    let suffix: String
    
    var url: String {
        return "\(prefix)128\(suffix)"
    }
}
