//
//  VenueViewModel.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation
import Observation

@Observable
@MainActor
class VenueViewModel {
    private let venueRepository: VenueRepositoryProtocol
    private let locationService: LocationServiceProtocol
    private(set) var venues: [Venue] = []

    var isLoading: Bool = false
    var error: Error?
    
    init(venueRepository: VenueRepositoryProtocol = VenueRepository(), locationService: LocationServiceProtocol = LocationService()) {
        self.venueRepository = venueRepository
        self.locationService = locationService
    }
    
    func fetchVenues(limit: Int) async {
        isLoading = true
        error = nil
        
        do {
            let venues = try await venueRepository.getVenues(limit: limit)
            self.venues = venues
        } catch {
            self.error = error
        }
    }
    
    func openMap(for venue: Venue) {
        Task {
            do {
                try await locationService.openMapsWithAddress(venue.location.formattedAddress ?? "")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
}
