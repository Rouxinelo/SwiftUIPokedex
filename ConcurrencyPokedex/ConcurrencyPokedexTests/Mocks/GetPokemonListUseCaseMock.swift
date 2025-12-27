//
//  GetPokemonListUseCaseMock.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 27/12/2025.
//

import Foundation
@testable import ConcurrencyPokedex

struct GetPokemonListUseCaseMock: GetPokemonListUseCaseProtocol {
    func perform(limit: Int, offset: Int) async throws -> any PokemonListRepresentable {
        PokemonListRepresentableMock()
    }
}
