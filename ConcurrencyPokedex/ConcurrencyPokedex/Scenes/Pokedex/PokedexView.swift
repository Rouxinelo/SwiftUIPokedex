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
        ZStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.pokemons, id: \.id) { item in
                        PokedexPokemonView(pokemon: item)
                            .onAppear {
                                loadMoreIfNeeded(currentItem: item)
                            }
                    }
                }
                .padding(10)
                if viewModel.isLoading { TableLoadingView() }
            }
            .task { await viewModel.fetchPokemon() }
            
            if viewModel.isFirstLoading { FullScreenLoadingView() }
        }
    }
    
    private func loadMoreIfNeeded(currentItem: any PokemonRepresentable) {
        guard !viewModel.isLoading, currentItem.id == viewModel.pokemons.last?.id else { return }
        Task {
            await viewModel.fetchPokemon()
        }
    }
}

#Preview {
    let appDependencies = AppDependencies(networkProvider: NetworkProvider())
    return PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: appDependencies.getPokemonListUseCase,
                                            getPokemonUseCase: appDependencies.getPokemonUseCase))
}
