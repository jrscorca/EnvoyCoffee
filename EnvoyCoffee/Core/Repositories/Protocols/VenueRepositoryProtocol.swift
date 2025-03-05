//
//  VenueRepositoryProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

protocol VenueRepositoryProtocol: Sendable {
    func updateQuery(_ query: String) async
    func updateLocation(latitude: Double, longitude: Double) async
    func updateRadius(_ radius: String) async
    func getVenues(limit: Int) async throws -> [Venue]
}
