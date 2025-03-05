//
//  MockHTTPClient.swift
//  EnvoyCoffeeTests
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation
@testable import EnvoyCoffee

struct MockHTTPClient: HTTPClient {
    var mockData: Data?
    var mockResponse: HTTPURLResponse?
    var mockError: Error?
    
    func execute(request: URLRequest) async throws -> (Data, HTTPURLResponse) {
        
        guard let data = mockData,
        let response = mockResponse else {
            throw URLError(.unknown)
        }
        
        return (data, response)
    }
    
}
