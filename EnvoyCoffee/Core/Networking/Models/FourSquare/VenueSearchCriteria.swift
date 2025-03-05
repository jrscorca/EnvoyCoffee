//
//  VenueSearchCriteria.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation
import Observation

@Observable
final class VenueSearchCriteria {
    var latitude: Double = 37.7777
    var longitude: Double = -122.3952
    var query: String = "coffee"
    var radius: String = "1600" // 1600 meter, ~1 mile
    var limit: String = "10"
    var sortBy: String? = "DISTANCE"
    
    func queryItems() -> [URLQueryItem] {
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "ll", value: "\(latitude),\(longitude)"),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "radius", value: radius),
            URLQueryItem(name: "limit", value: limit),
            URLQueryItem(name: "sort", value: sortBy)
        ]
        
        return queryItems
    }
    
    
}
