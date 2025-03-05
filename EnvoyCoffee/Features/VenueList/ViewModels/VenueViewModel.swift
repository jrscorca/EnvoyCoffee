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
    private(set) var venues: [Venue] = []
    
    var searchCriteria = VenueSearchCriteria()
    var isLoading: Bool = false
    var error: Error?
    
    init(venueRepository: VenueRepositoryProtocol = VenueRepository()) {
        self.venueRepository = venueRepository
    }
    
    func fetchVenues() async {
        isLoading = true
        error = nil
        
        do {
            let venues = try await venueRepository.getVenues(limit: 10)
            self.venues = venues
        } catch {
            self.error = error
        }
    }
    
}
