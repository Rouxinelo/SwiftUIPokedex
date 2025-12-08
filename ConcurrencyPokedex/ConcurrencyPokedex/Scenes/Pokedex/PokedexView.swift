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
            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Image("navBarPokeball")
                        .resizable()
                        .frame(width: 24, height: 24)
                    Text("Pokedex")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                .padding(.horizontal)
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
            }
            .task { await viewModel.fetchPokemon() }
            
            if viewModel.isFirstLoading { FullScreenLoadingView() }
        }
    }
}

private extension PokedexView {
    func loadMoreIfNeeded(currentItem: any PokemonRepresentable) {
        guard shouldReloadPokemon(currentItem: currentItem) else { return }
        Task {
            await viewModel.fetchPokemon()
        }
    }
    
    private func shouldReloadPokemon(currentItem: any PokemonRepresentable) -> Bool {
        !viewModel.isLoading && currentItem.id == viewModel.pokemons.last?.id
    }
}

#Preview {
    let appDependencies = AppDependencies(networkProvider: NetworkProvider())
    return PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: appDependencies.getPokemonListUseCase,
                                                   getPokemonUseCase: appDependencies.getPokemonUseCase))
}
