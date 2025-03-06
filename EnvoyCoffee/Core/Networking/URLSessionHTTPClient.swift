//
//  URLSessionHTTPClient.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

struct URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    // API key is hardcoded here, but in production we should consider storing elsewhere
    private let apiKey = "fsq37fyXWzLyavOuzwKG/gxF0/ALauoEc4ravo1nXnA9aVo="
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func execute(request: inout URLRequest) async throws -> (Data, HTTPURLResponse) {
        request.addValue(apiKey, forHTTPHeaderField: "Authorization")
        let (data, response) = try await session.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        
        return (data, httpResponse)
    }
}
