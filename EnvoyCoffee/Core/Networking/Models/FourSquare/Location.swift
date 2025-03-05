//
//  Location.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct Location: Decodable {
    let address: String?
    let formattedAddress: String?
    let locality: String?
    let region: String?
    let country: String?
    
    enum CodingKeys: String, CodingKey {
        case address, locality, region, country
        case formattedAddress = "formatted_address"
    }
}
