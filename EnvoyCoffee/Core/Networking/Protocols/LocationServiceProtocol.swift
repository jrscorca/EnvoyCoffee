//
//  LocationServiceProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import CoreLocation

protocol LocationServiceProtocol: Sendable {
    func getCoordinates(for address: String) async throws -> CLLocationCoordinate2D
}
