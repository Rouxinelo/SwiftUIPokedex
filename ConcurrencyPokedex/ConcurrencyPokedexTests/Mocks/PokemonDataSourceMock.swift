//
//  PokemonDataSourceMock.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 28/12/2025.
//

import Foundation
@testable import ConcurrencyPokedex

struct PokemonDataSourceMock: PokemonDataSourceProtocol {
    func getPokemonList(limit: Int, offset: Int) async throws -> any PokemonListRepresentable {
        PokemonListRepresentableMock(results: Array(repeating: PokemonEntryRepresentableMock(), count: limit))
    }
    
    func getPokemon(id: String) async throws -> any PokemonRepresentable {
        PokemonRepresentableMock(id: Int(id) ?? 0)
    }
}
