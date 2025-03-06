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
    
    func searchVenues(searchCriteria: VenueSearchCriteria) async throws -> (venues: [Venue], nextCursor: String?) {
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
        
        // Parse next cursor from Link header
        let nextCursor = extractNextCursor(from: response)
        
        let decoder = JSONDecoder()
        let venueResponse = try decoder.decode(VenueResponse.self, from: data)
        return (venueResponse.results, nextCursor)
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
        
        let photos = try decoder.decode([Photo].self, from: data)
        return photos
    }
    
    private func extractNextCursor(from response: HTTPURLResponse) -> String? {
        guard let linkHeader = response.allHeaderFields["Link"] as? String else {
            return nil
        }
        
        // Parse the Link header to extract the cursor value
        // Format: <https://api.foursquare.com/v3/places/search?near=los%20angeles%2C%20ca&cursor=c3l6MTA&query=pizza>; rel="next"
        let pattern = "cursor=([^&>]+)"
        let regex = try? NSRegularExpression(pattern: pattern, options: [])
        guard let regex = regex,
              let match = regex.firstMatch(in: linkHeader, options: [], range: NSRange(location: 0, length: linkHeader.utf16.count)) else {
            return nil
        }
        
        if let range = Range(match.range(at: 1), in: linkHeader) {
            return String(linkHeader[range])
        }
        
        return nil
    }
}
