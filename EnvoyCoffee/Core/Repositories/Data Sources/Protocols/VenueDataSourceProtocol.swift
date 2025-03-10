//
//  VenueDataSourceProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/8/25.
//

import Foundation

protocol VenueDataSourceProtocol: Sendable {
    func load() async throws -> [Venue]
    func add(venues: [Venue]) async throws
    func clear() async
}
