////
////  CoreDataVenueDataSource.swift
////  EnvoyCoffee
////
////  Created by Joshua Scorca on 3/10/25.
////
//
//import Foundation
//import CoreData
//
//final class CoreDataVenueDataSource: VenueDataSourceProtocol {
//    let container: NSPersistentContainer
//    
//    init(container: NSPersistentContainer = NSPersistentContainer(name: "EnvoyCoffee")) {
//        self.container = container
//        container.loadPersistentStores() { description, error in
//            if let error {
//                print(error.localizedDescription)
//            }
//        }
//    }
//    
//    func load(limit: Int? = nil) async throws -> ([Venue], Bool) {
//        try await container.performBackgroundTask { [weak self] context in
//            guard let strongSelf = self else { return }
//            let fetchRequest = NSFetchRequest<VenueEntity>(entityName: "VenueEntity")
//            fetchRequest.fetchBatchSize = 10
//            let entities = try context.fetch(fetchRequest)
//            var results: [Venue] = []
//            for entity in entities {
//                results.append(strongSelf.makeVenue(from: entity))
//            }
//        }
//        return []
//    }
//    
//    func add(venues: [Venue]) async throws {
//        // stubs
//    }
//    
//    func clear() async {
//        // stubs
//    }
//    
//    private func makeVenue(from entity: VenueEntity) -> Venue {
//        // Map location
//        let location = Location(
//            address: entity.location?.address,
//            formattedAddress: entity.location?.formattedAddress,
//            locality: nil,
//            region: nil,
//            country: nil
//        )
//        
//        // Map photo if exists
//        var photo: Photo? = nil
//        if let photoEntity = entity.photo {
//            photo = Photo(
//                id: photoEntity.id ?? "",
//                prefix: photoEntity.prefix ?? "",
//                suffix: photoEntity.suffix ?? "",
//                width: nil,
//                height: nil
//            )
//        }
//        
//        // For simplicity, we're skipping categories as mentioned
//        return Venue(
//            id: entity.id ?? "",
//            name: entity.name ?? "",
//            categories: nil,
//            distance: Int(entity.distance),
//            location: location,
//            photo: photo
//        )
//    }
//    
//    
//}
