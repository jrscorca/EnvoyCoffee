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

    var isLoading: Bool = false
    var error: Error?
    
    init(venueRepository: VenueRepositoryProtocol = VenueRepository()) {
        self.venueRepository = venueRepository
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
    
    private func fetchPhotosForVenues(venues: inout [Venue]) async {
            for i in 0..<venues.count {
                do {
                    let photos = try await venueService.fetchVenuePhotos(venueId: venues[i].id, limit: 1)
                    if let photo = photos.first {
                        venues[i].photo = photo
                    }
                } catch {
                    // Just log the error but continue, we don't want to fail the entire operation
                    print("Failed to fetch photo for venue \(venues[i].id): \(error.localizedDescription)")
                }
            }
        }
    
}
