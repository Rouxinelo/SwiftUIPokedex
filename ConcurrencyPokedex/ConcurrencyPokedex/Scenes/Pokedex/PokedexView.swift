//
//  ContentView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

struct PokedexView: View {
    @StateObject var viewModel: PokedexViewModel
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.pokemons, id: \.id) { item in
                    PokedexPokemonView(pokemon: item)
                }
            }
            .padding()
        }
        .task {
            await viewModel.fetchPokemon()
        }
    }
}

#Preview {
    let appDependencies = AppDependencies(networkProvider: NetworkProvider())
    return PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: appDependencies.getPokemonListUseCase,
                                            getPokemonUseCase: appDependencies.getPokemonUseCase))
}
