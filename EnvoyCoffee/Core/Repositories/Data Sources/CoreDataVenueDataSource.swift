//
//  CoreDataVenueDataSource.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/10/25.
//

import Foundation
import CoreData

final class CoreDataVenueDataSource: VenueDataSourceProtocol {
    let container: NSPersistentContainer
    
    init(container: NSPersistentContainer = NSPersistentContainer(name: "EnvoyCoffee")) {
        self.container = container
    }
    
    func load() async throws -> [Venue] {
        // stubs
        return []
    }
    
    func add(venues: [Venue]) async throws {
        // stubs
    }
    
    func clear() async {
        // stubs
    }
    

    
    
}
