//
//  UserDefaultsVenueDataSource.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/8/25.
//

import Foundation

actor UserDefaultsVenueDataSource: VenueDataSourceProtocol {
    private var cursor: Bool = false
    private var offset: Int = 0
    func load(_ limit: Int? = nil) async throws -> ([Venue], Bool) {
        //load 10 at a time
        
        guard let savedData = UserDefaults.standard.data(forKey: "venues") else {
            return ([], false)
        }
        let results = try JSONDecoder().decode([Venue].self, from: savedData)
        print("RESULTS.count = \(results.count)")
        if let limit {
            
            var tenResults: [Venue] = []
            cursor = true
            for i in offset..<offset+limit {
                if i == results.count {
                    cursor = false
                    break
                }
                tenResults.append(results[i])

            }
            offset += limit
            print("tenResults.count = \(tenResults.count)")
            return (tenResults, cursor)
        } else {
            return (results, false)
        }
        
    }
    
    func add(venues: [Venue]) async throws {
        var (currentVenues, _) = try await self.load()
        currentVenues.append(contentsOf: venues)
        let savedData = try JSONEncoder().encode(currentVenues)
        UserDefaults.standard.set(savedData, forKey: "venues")
        
    }
    
    func clear() async {
        offset = 0
        cursor = false
        UserDefaults.standard.removeObject(forKey: "venues")
    }
}
