//
//  MockVenueRepository.swift
//  EnvoyCoffeeTests
//
//  Created by Joshua Scorca on 3/6/25.
//

import Foundation
@testable import EnvoyCoffee

final class MockVenueRepository: VenueRepositoryProtocol {
    func updateQuery(_ query: String) async {
        // stub
    }
    
    func updateAddress(_ address: String) async throws {
        // stub
    }
    
    func updateRadius(_ radius: String) async {
        // stub
    }
    
    func getVenues(limit: Int, loadMore: Bool) async throws -> (venues: [Venue], hasMore: Bool) {
        let venueA = Venue(id: "testID",
              name: "testName",
              categories: nil,
              distance: nil,
              location: Location(address: nil, formattedAddress: nil, locality: nil, region: nil, country: nil),
              photo: nil)
        return ([venueA], false)
    }
    
    func resetPagination() async {
        // stub
    }
    
}
