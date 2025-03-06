//
//  Photo.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

struct PhotoResponse: Decodable {
    let photos: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case photos = "results"
    }
}

struct Photo: Decodable, Identifiable {
    let id: String
    let prefix: String
    let suffix: String
    let width: Int
    let height: Int
    
    var originalImageURL: URL? {
        URL(string: "\(prefix)original\(suffix)")
    }
    
    var thumbnailURL: URL? {
        // For thumbnails, we use a smaller size (100x100)
        URL(string: "\(prefix)100x100\(suffix)")
    }
}
