//
//  FourSquareEndpoint.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

enum FourSquareEndpoint {
    case searchPlaces
    
    var url: URL {
        let baseURL = "https://api.foursquare.com/v3/"
        
        let urlString: String
        switch self {
        case .searchPlaces:
            urlString = "\(baseURL)places/search"
        }
        
        // This will catch malformed URLs
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL format: \(urlString)")
        }
        
        return url
    }
}
