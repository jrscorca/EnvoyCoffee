//
//  FourSquareServiceProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

protocol FourSquareServiceProtocol: Sendable {
    func searchVenues(searchCriteria: VenueSearchCriteria) async throws -> [Venue] 
}
