//
//  ContentView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

struct PokedexView: View {
    @StateObject var viewModel: PokedexViewModel
    
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    
    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                getNavigationBar()
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(viewModel.pokemons, id: \.id) { item in
                            PokedexPokemonView(pokemon: item)
                                .onAppear { loadMoreIfNeeded(currentItem: item) }
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
    func getNavigationBar() -> NavigationBar {
        NavigationBar(title: viewModel.screenType == .allPokemon ? "Pokédex" : "Favorites",
                             buttons: getNavigationBarButtons())
    }
    
    func getNavigationBarButtons() -> [NavigationBarItem] {
        var buttons = [NavigationBarItem(name: "Search",
                                         image: "magnifyingglass",
                                         action: { viewModel.didTapSearch() })]
        if viewModel.screenType == .allPokemon {
            buttons.append(NavigationBarItem(name: "Team",
                                             image: "heart.fill",
                                             action: { viewModel.switchScreenType() }))
        } else {
            buttons.append(NavigationBarItem(name: "All",
                                             image: "heart",
                                             action: { viewModel.switchScreenType() }))
        }
        return buttons
    }
    
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
