//
//  DiskImageRepository.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import SwiftUI

struct DiskImageRepository: ImageRepositoryProtocol {
    
    let imageService: ImageServiceProtocol
    
    init(imageService: ImageServiceProtocol = ImageService()) {
        self.imageService = imageService
    }
    
    func get(from url: URL) async throws -> UIImage? {
        if let imageData = try loadImageFromCache(url: url) {
            return UIImage(data: imageData)
        }
        
        let data = try await imageService.fetchImageData(url: url)
        try saveImageToCache(data: data, url: url)
        
        return UIImage(data: data)
    }
    
    func cancelFetch(for url: URL) async {
        await imageService.cancelFetch(url: url)
    }
    
    private func saveImageToCache(data: Data, url: URL) throws {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw URLError(.fileDoesNotExist)
        }
        
        let fileURL = cacheDirectory.appendingPathComponent(url.absoluteString.hash.description)
        do {
            try FileManager.default.createDirectory(at: fileURL.deletingLastPathComponent(),
                                                    withIntermediateDirectories: true)
            try data.write(to: fileURL)
        }
    }
    
    private func loadImageFromCache(url: URL) throws -> Data? {
        guard let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            throw URLError(.fileDoesNotExist)
        }
        let fileURL = cacheDirectory.appendingPathComponent(url.absoluteString.hash.description)
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                return try Data(contentsOf: fileURL)
            }
        }
        return nil
    }
    
}
