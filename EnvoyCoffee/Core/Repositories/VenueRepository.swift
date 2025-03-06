//
//  VenueRepository.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

final class VenueRepository : VenueRepositoryProtocol {

    private let venueSearchCriteriaActor = VenueSearchCriteriaActor()
    private let venueService: VenueServiceProtocol
    private let locationService: LocationServiceProtocol
    
    init(venueService: VenueServiceProtocol = VenueAPIService(), locationService: LocationServiceProtocol = LocationService()) {
        self.venueService = venueService
        self.locationService = locationService
    }
    
    func updateRadius(_ radius: String) async {
        await venueSearchCriteriaActor.updateRadius(radius)
    }
    
    func updateQuery(_ query: String) async {
        await venueSearchCriteriaActor.updateQuery(query)
    }
    
    func updateAddress(_ address: String) async throws {
        let location = try await locationService.getCoordinates(for: address)
        await venueSearchCriteriaActor.updateLocation(latitude: location.latitude, longitude: location.longitude)
    }
    
    func getVenues(limit: Int = 10) async throws -> [Venue] {
        await venueSearchCriteriaActor.updateLimit(String(limit))
        let searchCriteria = await venueSearchCriteriaActor.criteria
        var venues = try await venueService.searchVenues(searchCriteria: searchCriteria)
        
        // setup relationship for venues and photos
        await fetchPhotosForVenues(venues: &venues)
        
        return venues
        
    }
    
    private func fetchPhotosForVenues(venues: inout [Venue]) async {
        for i in 0..<venues.count {
            do {
                let photos = try await venueService.fetchVenuePhotos(venueId: venues[i].id, limit: 1)
                if let photo = photos.first {
                    venues[i].photo = photo
                }
            } catch {
                print("Failed to fetch photo for venue \(venues[i].id): \(error.localizedDescription)")
            }
        }
    }
    
    private func updateLocation(latitude: Double, longitude: Double) async {
        await venueSearchCriteriaActor.updateLocation(latitude: latitude, longitude: longitude)
    }
    
}
