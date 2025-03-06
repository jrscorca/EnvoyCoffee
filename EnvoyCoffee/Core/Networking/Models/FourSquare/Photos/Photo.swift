//
//  Photo.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import Foundation

struct PhotoResponse: Decodable {
    let photos: [Photo]
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
        URL(string: "\(prefix)200x200\(suffix)")
    }
}
