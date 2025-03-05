//
//  VenueRepository.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

final class VenueRepository : VenueRepositoryProtocol {
    
    private let venueSearchCriteriaActor = VenueSearchCriteriaActor()
    private let service: VenueServiceProtocol
    
    init(service: VenueServiceProtocol = VenueAPIService()) {
        self.service = service
    }
    
    func updateRadius(_ radius: String) async {
        await venueSearchCriteriaActor.updateRadius(radius)
    }
    
    func updateQuery(_ query: String) async {
        await venueSearchCriteriaActor.updateQuery(query)
    }
    
    func updateLocation(latitude: Double, longitude: Double) async {
        await venueSearchCriteriaActor.updateLocation(latitude: latitude, longitude: longitude)
    }
    
    func getVenues(limit: Int = 10) async throws -> [Venue] {
        await venueSearchCriteriaActor.updateLimit(String(limit))
        let searchCriteria = await venueSearchCriteriaActor.criteria
        return try await service.searchVenues(searchCriteria: searchCriteria)
    }
    
    private actor VenueSearchCriteriaActor {
        var criteria = VenueSearchCriteria()
        
        func updateQuery(_ query: String) {
            criteria.query = query
        }
        
        func updateRadius(_ radius: String) {
            criteria.radius = radius
        }
        
        func updateLimit(_ limit: String) {
            criteria.radius = limit
        }
        
        func updateLocation(latitude: Double, longitude: Double) {
            criteria.latitude = latitude
            criteria.longitude = longitude
        }
    }
}
