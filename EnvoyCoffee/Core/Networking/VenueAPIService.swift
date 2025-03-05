//
//  VenueAPIService.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct VenueAPIService: VenueServiceProtocol {
    private let httpClient: HTTPClient
    
    // API key is hardcoded here, but in production we should consider storing elsewhere
    private let apiKey = "fsq37fyXWzLyavOuzwKG/gxF0/ALauoEc4ravo1nXnA9aVo="
    
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
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let (data, response) = try await httpClient.execute(request: request)
        
        if response.statusCode != 200 {
            throw URLError(.badServerResponse)
        }
        
        let decoder = JSONDecoder()
        let venueResponse = try decoder.decode(VenueResponse.self, from: data)
        return venueResponse.results
    }

}
