//
//  GetPokemonUseCase.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol GetPokemonUseCaseProtocol {
    func perform(id: String) async throws -> any PokemonRepresentable
}

class GetPokemonUseCase: GetPokemonUseCaseProtocol {
    let dataSource: PokemonDataSourceProtocol
    
    init(dataSource: PokemonDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func perform(id: String) async throws -> any PokemonRepresentable {
        try await dataSource.getPokemon(id: id)
    }
}
