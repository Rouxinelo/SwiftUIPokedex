//
//  GetPokemonListUseCase.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol GetPokemonListUseCaseProtocol {
    func perform(limit: Int, offset: Int) async throws -> PokemonListRepresentable
}
