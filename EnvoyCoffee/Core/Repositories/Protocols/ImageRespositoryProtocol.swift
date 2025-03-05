//
//  ImageRespositoryProtocol.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import SwiftUI

protocol ImageRepositoryProtocol: Sendable{
    func get(from url: URL) async throws -> UIImage?
    func cancelFetch(for url: URL) async
}
