//
//  NetworkProvider.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol NetworkProviderProtocol {
    func request(_ request: URLRequest) async throws -> Data
}

class NetworkProvider: NetworkProviderProtocol {
    func request(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
            throw NetworkingError.invalidStatusCode
        }
        return data
    }
}
