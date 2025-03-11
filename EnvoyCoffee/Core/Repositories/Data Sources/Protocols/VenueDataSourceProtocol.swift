//
//  VenueDataSourceProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/8/25.
//

import Foundation

protocol VenueDataSourceProtocol: Sendable {
    func load(_ limit: Int?) async throws -> ([Venue], Bool)
    func add(venues: [Venue]) async throws
    func clear() async
}
