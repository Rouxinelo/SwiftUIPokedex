//
//  ContentView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

struct PokedexView: View {
    @StateObject var viewModel: PokedexViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    init(viewModel: PokedexViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 10) {
                navigationBar
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {
                        ForEach(pokemons, id: \.id) { item in
                            PokedexPokemonView(pokemon: item, onClick: {
                                goToPokemonDetail(item)
                            })
                                .onAppear { loadMoreIfNeeded(currentItem: item) }
                        }
                    }
                    .padding(10)
                    if viewModel.isLoading { TableLoadingView() }
                }
            }
            .task { await viewModel.fetchPokemon() }
            .onAppear { viewModel.requestHealthPermissionsAuthorization() }
            if viewModel.isFirstLoading { FullScreenLoadingView() }
        }
    }
}

private extension PokedexView {
    var navigationBar: NavigationBar {
        NavigationBar(title: viewModel.screenType == .allPokemon ? "Pokédex" : "Favorites",
                      buttons: navigationBarButtons)
    }
    
    var navigationBarButtons: [NavigationBarItem] {
        let isFavorite = viewModel.screenType == .favorite
        var buttons = [NavigationBarItem(name: "Search",
                                         image: "magnifyingglass",
                                         action: { viewModel.didTapSearch() })]
        
        buttons.append(NavigationBarItem(name: isFavorite ? "Team" : "All",
                                         image: isFavorite ? "heart.fill" : "heart",
                                         action: { viewModel.switchScreenType() }))
        return buttons
    }
    
    var pokemons: [any PokemonRepresentable] {
        switch viewModel.screenType {
        case .allPokemon:
            return viewModel.pokemons
        case .favorite:
            return viewModel.favoritePokemons
        }
    }
    
    func loadMoreIfNeeded(currentItem: any PokemonRepresentable) {
        guard shouldReloadPokemon(currentItem: currentItem) else { return }
        Task {
            await viewModel.fetchPokemon()
        }
    }
    
    func shouldReloadPokemon(currentItem: any PokemonRepresentable) -> Bool {
        !viewModel.isLoading && currentItem.id == viewModel.pokemons.last?.id
    }
    
    func goToPokemonDetail(_ pokemon: any PokemonRepresentable) {
        Router.shared.navigate(to: .pokemonDetail(pokemon))
    }
}
