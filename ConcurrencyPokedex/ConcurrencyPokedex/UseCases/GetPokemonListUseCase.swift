//
//  GetPokemonListUseCase.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol GetPokemonListUseCaseProtocol {
    func perform(limit: Int, offset: Int) async throws -> any PokemonListRepresentable
}

class GetPokemonListUseCase: GetPokemonListUseCaseProtocol {
    let dataSource: PokemonDataSourceProtocol
    
    init(dataSource: PokemonDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    func perform(limit: Int, offset: Int) async throws -> any PokemonListRepresentable {
        try await dataSource.getPokemonList(limit: limit, offset: offset)
    }
}
