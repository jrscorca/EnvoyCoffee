//
//  VenueSearchCriteriaActor.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

actor VenueSearchCriteriaActor {
    var criteria = VenueSearchCriteria()
    
    func updateQuery(_ query: String) {
        criteria.query = query
    }
    
    func updateRadius(_ radius: String) {
        criteria.radius = radius
    }
    
    func updateLimit(_ limit: String) {
        criteria.limit = limit
    }
    
    func updateLocation(latitude: Double, longitude: Double) {
        criteria.latitude = latitude
        criteria.longitude = longitude
    }
}
