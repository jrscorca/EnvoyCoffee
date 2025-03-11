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
    private let venueDataSource: VenueDataSourceProtocol
    
    init(venueService: VenueServiceProtocol = VenueAPIService(),
         locationService: LocationServiceProtocol = LocationService(),
         venueDataSource: VenueDataSourceProtocol = UserDefaultsVenueDataSource()
    ) {
        self.venueService = venueService
        self.locationService = locationService
        self.venueDataSource = venueDataSource
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
    
    func getVenues(limit: Int = 10, loadMore: Bool = false) async throws -> (venues: [Venue], hasMore: Bool) {
        // If not loading more, reset the cursor
        // Important for new searches
        var clearCache: Bool = false
        if !loadMore {
            await venueSearchCriteriaActor.resetCursor()
            clearCache = true
        }
        
        await venueSearchCriteriaActor.updateLimit(String(limit))
        let searchCriteria = await venueSearchCriteriaActor.criteria
        do {
            let (venues, nextCursor) = try await venueService.searchVenues(searchCriteria: searchCriteria)
            
            // Update cursor for next page if available
            if let nextCursor = nextCursor {
                await venueSearchCriteriaActor.updateCursor(nextCursor)
            }
            
            // setup relationship for venues and photos
            var venuesWithPhotos = venues
            await fetchPhotosForVenues(venues: &venuesWithPhotos)
            
            //save the venues locally
            if clearCache {
                await venueDataSource.clear()
            }
            try await venueDataSource.add(venues: venuesWithPhotos)
            
            return (venuesWithPhotos, nextCursor != nil)
        } catch {
            print(error.localizedDescription)
            return try await venueDataSource.load(limit)
        }
        
    }
    
    func resetPagination() async {
        await venueSearchCriteriaActor.resetCursor()
    }
    
    private func fetchPhotosForVenues(venues: inout [Venue]) async {
        // Using task group to handle concurrent photo fetching
        await withTaskGroup(of: (index: Int, photo: Photo?).self) { [weak self] group in
            guard let strongSelf = self else {
                return
            }
            // Add a task for each venue
            for i in 0..<venues.count {
                let venueId = venues[i].id
                
                group.addTask {
                    do {
                        let photos = try await strongSelf.venueService.fetchVenuePhotos(venueId: venueId, limit: 1)
                        return (index: i, photo: photos.first)
                    } catch {
                        print("Failed to fetch photo for venue \(venueId): \(error.localizedDescription)")
                        return (index: i, photo: nil)
                    }
                }
            }
            
            // Process the results as they complete
            for await result in group {
                if let photo = result.photo {
                    venues[result.index].photo = photo
                }
            }
        }
    }
    
    private func updateLocation(latitude: Double, longitude: Double) async {
        await venueSearchCriteriaActor.updateLocation(latitude: latitude, longitude: longitude)
    }
    
}
