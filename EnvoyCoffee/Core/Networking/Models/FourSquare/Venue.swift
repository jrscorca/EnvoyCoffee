//
//  Venue.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation
import CoreLocation

struct VenueResponse: Decodable {
    let results: [Venue]
}

struct Venue: Decodable, Identifiable {
    let id: String
    let name: String
    let categories: [Category]?
    let distance: Int?
    let location: Location
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case name, categories, distance, location
    }
}
