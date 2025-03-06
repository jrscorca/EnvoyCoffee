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

    
    var isLoading: Bool = false // loading initial venues
    var isLoadingMore: Bool = false // for infinite scrolling
    var error: Error?
    var hasMoreResults: Bool = true
    private let itemsPerPage: Int = 10
    
    init(venueRepository: VenueRepositoryProtocol = VenueRepository(), locationService: LocationServiceProtocol = LocationService()) {
        self.venueRepository = venueRepository
        self.locationService = locationService
    }
    
    // Initial fetch
    func fetchVenues() async {
        isLoading = true
        error = nil
        
        do {
            // Reset pagination and get initial set of venues
            await venueRepository.resetPagination()
            let result = try await venueRepository.getVenues(limit: itemsPerPage, loadMore: false)
            self.venues = result.venues
            hasMoreResults = result.hasMore
        } catch {
            self.error = error
        }
        
        isLoading = false
    }
    
    // Pagination
    func loadMoreVenues() async {
            // Don't load more if we're already loading or there are no more results
            guard !isLoading && !isLoadingMore && hasMoreResults else { return }
            
            isLoadingMore = true
            
            do {
                // Get next page using cursor
                let (additionalVenues, hasMore) = try await venueRepository.getVenues(limit: itemsPerPage, loadMore: true)
                
                // Update hasMoreResults flag based on cursor presence
                hasMoreResults = hasMore
                
                // Append new venues to existing list
                self.venues.append(contentsOf: additionalVenues)
            } catch {
                self.error = error
            }
            
            isLoadingMore = false
        }
        
        func refresh() async {
            await fetchVenues()
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
