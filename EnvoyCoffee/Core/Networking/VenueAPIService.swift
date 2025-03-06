//
//  VenueAPIService.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct VenueAPIService: VenueServiceProtocol {
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSessionHTTPClient()) {
        self.httpClient = httpClient
    }
    
    func searchVenues(searchCriteria: VenueSearchCriteria) async throws -> [Venue] {
        guard var components = URLComponents(url: FourSquareEndpoint.searchPlaces.url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = searchCriteria.queryItems()
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await httpClient.execute(request: &request)
        
        if response.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let venueResponse = try decoder.decode(VenueResponse.self, from: data)
        return venueResponse.results
    }
    
    func fetchVenuePhotos(venueId: String, limit: Int = 1) async throws -> [Photo] {
        let endpoint = FourSquareEndpoint.venuePhotos(venueID: venueId)
        guard var components = URLComponents(url: endpoint.url, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        
        components.queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await httpClient.execute(request: &request)
        
        if response.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        
        if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
           print(JSONString)
        }
        
        let photos = try decoder.decode([Photo].self, from: data)
        return photos
    }
    
}
