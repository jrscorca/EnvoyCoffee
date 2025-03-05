//
//  ImageServiceProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

protocol ImageServiceProtocol: Sendable {
    func fetchImageData(url: URL) async throws -> Data
    func cancelFetch(url: URL) async
}
