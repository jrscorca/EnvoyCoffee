//
//  UserDefaultsVenueDataSource.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/8/25.
//

import Foundation

actor UserDefaultsVenueDataSource: VenueDataSourceProtocol {
    func load() async throws -> [Venue] {
        
        guard let savedData = UserDefaults.standard.data(forKey: "venues") else {
            return []
        }
        let results = try JSONDecoder().decode([Venue].self, from: savedData)
        return results
        
    }
    
    func add(venues: [Venue]) async throws {
        var currentVenues = try await load()
        currentVenues.append(contentsOf: venues)
        let savedData = try JSONEncoder().encode(currentVenues)
        UserDefaults.standard.set(savedData, forKey: "venues")
        
    }
    
    func clear() async {
        UserDefaults.standard.removeObject(forKey: "venues")
    }
}
