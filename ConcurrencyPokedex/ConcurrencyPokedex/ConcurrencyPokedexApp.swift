//
//  ConcurrencyPokedexApp.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

@main
struct ConcurrencyPokedexApp: App {
    var appDependencies = AppDependencies(networkProvider: NetworkProvider())
    
    var body: some Scene {
        WindowGroup {
            PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: appDependencies.getPokemonListUseCase,
                                                    getPokemonUseCase: appDependencies.getPokemonUseCase))
        }
    }
}
