//
//  PokemonDataSource.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol PokemonDataSourceProtocol {
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListDTO
    func getPokemon(id: Int) async throws -> PokemonDTO
}

class PokemonDataSource: PokemonDataSourceProtocol {
    private let network: NetworkProviderProtocol
    private let pokemonEndpoint = "https://pokeapi.co/api/v2/pokemon"
    private let getMethod = "GET"
    
    init(network: NetworkProviderProtocol) {
        self.network = network
    }
    
    func getPokemonList(limit: Int, offset: Int) async throws -> PokemonListDTO {
        guard let url = URL(string: "\(pokemonEndpoint)?limit=\(limit)&offset=\(offset)") else { 
            throw NetworkingError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = getMethod

        let data = try await network.request(request)
        return try JSONDecoder().decode(PokemonListDTO.self, from: data)
    }
    
    func getPokemon(id: Int) async throws -> PokemonDTO {
        guard let url = URL(string: "\(pokemonEndpoint)/\(id)") else {
            throw NetworkingError.invalidURL
        }
        var request = URLRequest(url: url)
        request.httpMethod = getMethod

        let data = try await network.request(request)
        return try JSONDecoder().decode(PokemonDTO.self, from: data)
    }
}
