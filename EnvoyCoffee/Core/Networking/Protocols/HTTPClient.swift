//
//  HTTPClient.swift
//  EnvoyCoffee
//
//  Created by Joshua Scorca on 3/4/25.
//

import Foundation

protocol HTTPClient: Sendable {
    func execute(request: URLRequest) async throws -> (Data, HTTPURLResponse)
}
