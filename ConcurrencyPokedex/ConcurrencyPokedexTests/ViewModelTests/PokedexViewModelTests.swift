//
//  PokedexViewModelTests.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 29/12/2025.
//

import XCTest
@testable import ConcurrencyPokedex

final class PokedexViewModelTests: XCTestCase {
    @MainActor
    var sut = PokedexViewModel(getPokemonListUseCase: GetPokemonListUseCaseMock(), getPokemonUseCase: GetPokemonUseCaseMock())
    
    func test_viewModel_pokemonArrayIsEmptyWhenStarting() async throws {
        let initialPokemon = await sut.pokemons
        
        XCTAssertTrue(initialPokemon.isEmpty)
    }
    
    func test_fetchPokemon_thenPokemonArrayIsFilledWithData() async throws {
        let initialPokemon = await sut.pokemons
        let limit = 20
        await sut.fetchPokemon()
        let finalPokemon = await sut.pokemons
        
        XCTAssertEqual(initialPokemon.count, 0)
        XCTAssertEqual(initialPokemon.count + limit, finalPokemon.count)
    }
}
