//
//  GetPokemonUseCaseMock.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 27/12/2025.
//

import Foundation
@testable import ConcurrencyPokedex

struct GetPokemonUseCaseMock: GetPokemonUseCaseProtocol {
    func perform(id: String) async throws -> any PokemonRepresentable {
        PokemonRepresentableMock()
    }
}
