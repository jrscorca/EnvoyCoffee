//
//  LocationService.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import SwiftUI
@preconcurrency import CoreLocation

enum LocationServiceError: Error {
    case geocodingFailed
    case noResultsFound
    case invalidAddress
    case invalidMapURL
}

struct LocationService: LocationServiceProtocol {
    
    private let geocoder: CLGeocoder
    
    init(geocoder: CLGeocoder = CLGeocoder()) {
        self.geocoder = geocoder
    }
    
    func openMapsWithAddress(_ address: String) async throws {
        guard let encodedAddress = address.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "maps://?address=\(encodedAddress)&navigate=yes") else {
            throw LocationServiceError.invalidMapURL
        }
        
        await MainActor.run {
            UIApplication.shared.open(url)
        }
    }
    
    func getCoordinates(for address: String) async throws -> CLLocationCoordinate2D {
        guard !address.isEmpty else {
            throw LocationServiceError.invalidAddress
        }
        
        do {
            let placemarks = try await geocoder.geocodeAddressString(address)
            
            guard let placemark = placemarks.first,
                  let location = placemark.location else {
                throw LocationServiceError.noResultsFound
            }
            
            return location.coordinate
        } catch {
            if let locationError = error as? LocationServiceError {
                throw locationError
            }
            throw LocationServiceError.geocodingFailed
        }
    }
}
