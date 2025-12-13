//
//  ConcurrencyPokedexApp.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

@main
struct ConcurrencyPokedexApp: App {
    @StateObject private var router = Router.shared
    var appDependencies = AppDependencies(networkProvider: NetworkProvider())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.path) {
                PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: appDependencies.getPokemonListUseCase,
                                                        getPokemonUseCase: appDependencies.getPokemonUseCase))
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .pokemonDetail(let pokemon):
                        PokemonDetailView(pokemon: pokemon)
                    }
                }
            }
        }
    }
}
