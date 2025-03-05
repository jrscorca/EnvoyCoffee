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
    private let fourSquareService: FourSquareServiceProtocol
    private(set) var venues: [Venue] = []
    
    var searchCriteria = VenueSearchCriteria()
    var isLoading: Bool = false
    var error: Error?
    
    init(fourSquareService: FourSquareServiceProtocol = FourSquareService()) {
        self.fourSquareService = fourSquareService
    }
    
    func fetchVenues() async {
        isLoading = true
        error = nil
        
        do {
            let venues = try await fourSquareService.searchVenues(searchCriteria: searchCriteria)
            self.venues = venues
        } catch {
            self.error = error
        }
    }
    
}
