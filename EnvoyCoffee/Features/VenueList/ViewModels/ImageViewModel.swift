//
//  ImageViewModel.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/5/25.
//

import SwiftUI

@Observable
@MainActor
public final class ImageViewModel {
    private let imageRepository: ImageRepositoryProtocol
    private let url : URL
    var image: UIImage?
    var error: Error?
    
    init(imageRepository: ImageRepositoryProtocol = DiskImageRepository(), url: URL) {
        self.imageRepository = imageRepository
        self.url = url
    }
    
    func fetchImage() async {
        error = nil
        do {
            image = try await imageRepository.get(from: url)
            let asdf = 0
        } catch {
            self.error = error
        }
    }
    
    func cancelImageFetch() async {
        await imageRepository.cancelFetch(for: url)
    }
}
