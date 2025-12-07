//
//  PokemonViewModel.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

@MainActor
class PokedexViewModel: ObservableObject {
    @Published var pokemons = [any PokemonRepresentable]()
    @Published var isLoading = false
    private var offset = 0
    private var limit = 20
    private var shouldLoadNextPage = true
    private var getPokemonListUseCase: GetPokemonListUseCaseProtocol
    private var getPokemonUseCase: GetPokemonUseCaseProtocol
    
    init(getPokemonListUseCase: GetPokemonListUseCaseProtocol, getPokemonUseCase: GetPokemonUseCaseProtocol) {
        self.getPokemonListUseCase = getPokemonListUseCase
        self.getPokemonUseCase = getPokemonUseCase
    }
    
    func fetchPokemon() async {
        guard shouldLoadNextPage, !isLoading else { return }
        isLoading = true
        
        do {
            let pokemonList = try await getPokemonListUseCase.perform(limit: limit, offset: offset)
            var newPokemon = [any PokemonRepresentable]()
            shouldLoadNextPage = pokemonList.next != nil

            try await withThrowingTaskGroup(of: (any PokemonRepresentable).self) { [weak self] group in
                guard let self = self else { return }
                
                for id in pokemonList.results {
                    group.addTask {
                        try await self.getPokemonUseCase.perform(id: id.name)
                    }
                }
                
                for try await pokemon in group {
                    newPokemon.append(pokemon)
                }
                
                pokemons.append(contentsOf: newPokemon.sorted { $0.id < $1.id })
                offset += limit
            }
        } catch {
            // TODO: Add Error Handling Here
        }
        isLoading = false
    }
}
