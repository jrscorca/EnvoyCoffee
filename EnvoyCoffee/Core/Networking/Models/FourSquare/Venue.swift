//
//  Venue.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation
import CoreLocation

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
    var photo: Photo? // This will be populated after fetching photos
    var distanceInMiles: String? {
        guard let distance = distance else { return nil }
        let miles = Double(distance) / 1609.34
        return String(format:"%.1f mi", miles)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "fsq_id"
        case name, categories, distance, location
    }
}
