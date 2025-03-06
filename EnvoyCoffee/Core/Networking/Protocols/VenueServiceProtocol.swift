//
//  VenueServiceProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

protocol VenueServiceProtocol: Sendable {
    func searchVenues(searchCriteria: VenueSearchCriteria) async throws -> (venues: [Venue], nextCursor: String?)
    func fetchVenuePhotos(venueId: String, limit: Int) async throws -> [Photo]
}
