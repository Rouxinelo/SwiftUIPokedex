//
//  PokemonViewModel.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation
import SwiftUI

enum PokedexScreenType {
    case allPokemon
    case favorite
}

enum PokedexScreenState {
    case fullScreenLoading
    case loadingNewPage
    case pokemonsLoaded
    case firstAccessBottomSheet
}

@MainActor
class PokedexViewModel: ObservableObject {
    @Environment(\.managedObjectContext)
    private var viewContext
    
    @Published var screenType: PokedexScreenType = .allPokemon
    @Published var pokemons = [any PokemonRepresentable]()
    @Published var favoritePokemons = [any PokemonRepresentable]()
    @Published var state: PokedexScreenState = .fullScreenLoading
    
    private var offset = 0
    private var limit = 20
    private var shouldLoadNextPage = true
    private var getPokemonListUseCase: GetPokemonListUseCaseProtocol
    private var getPokemonUseCase: GetPokemonUseCaseProtocol
    private var healthKitManager: PokemonHealthKitManagerProtocol
    
    init(getPokemonListUseCase: GetPokemonListUseCaseProtocol, getPokemonUseCase: GetPokemonUseCaseProtocol, healthKitManager: PokemonHealthKitManagerProtocol) {
        self.getPokemonListUseCase = getPokemonListUseCase
        self.getPokemonUseCase = getPokemonUseCase
        self.healthKitManager = healthKitManager
    }
    
    func fetchPokemon() async {
        guard shouldLoadNextPage, state != .loadingNewPage, state != .firstAccessBottomSheet else { return }
        
        if state != .fullScreenLoading { state = .loadingNewPage }
        
        do {
            let pokemonList = try await getPokemonListUseCase.perform(limit: limit, offset: offset)
            var pokemonData = [any PokemonRepresentable]()
            
            try await withThrowingTaskGroup(of: (any PokemonRepresentable).self) { [weak self] group in
                guard let self = self else { return }
                
                for result in pokemonList.results {
                    group.addTask { try await self.getPokemonUseCase.perform(id: result.name) }
                }
                
                for try await pokemon in group { pokemonData.append(pokemon) }
                
                pokemons.append(contentsOf: pokemonData.sorted { $0.id < $1.id })
                offset += limit
                shouldLoadNextPage = pokemonList.next != nil
                state = .pokemonsLoaded
            }
        } catch {
            // TODO: - Error Handling must be done here
        }
    }
    
    func onAppear() async {
        await checkIsFirstAccess()
    }
    
    func didCloseFirstAccessBottomSheet() async {
        setDidAlreadyShowBottomSheet()
        await requestHealthPermissionsAuthorization()
    }
    
    func didTapSearch() {
        // TODO: - Add search funcionality here
    }
    
    func switchScreenType() {
        switch screenType {
        case .allPokemon:
            screenType = .favorite
        case .favorite:
            screenType = .allPokemon
        }
    }
    
    func getLastPokemonId() -> Int? {
        pokemons.last?.id
    }
}

private extension PokedexViewModel {
    func checkIsFirstAccess() async {
        if !UserDefaults.standard.bool(forKey: "didAlreadyShowBottomSheet") {
            state = .firstAccessBottomSheet
        } else {
            await requestHealthPermissionsAuthorization()
        }
    }
    
    func setDidAlreadyShowBottomSheet() {
        UserDefaults.standard.setValue(true, forKey: "didAlreadyShowBottomSheet")
    }
    
    func handleHealthPermissionsAuthorization(_ hasPermissions: Bool) {
        guard healthKitManager.shouldUpdatePokeballStatus() else { return }
        healthKitManager.storeLastAccessDate()
    }
    
    func requestHealthPermissionsAuthorization() async {
        await performFirstLoading()
        healthKitManager.requestHealthPermissionsAuthorization(completion: { [weak self] hasPermissions, _ in
            self?.handleHealthPermissionsAuthorization(hasPermissions)
        })
    }
    
    func performFirstLoading() async {
        state = .fullScreenLoading
        await fetchPokemon()
    }
}
