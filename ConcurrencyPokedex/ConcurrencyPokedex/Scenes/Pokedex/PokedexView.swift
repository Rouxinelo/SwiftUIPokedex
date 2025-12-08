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
                ForEach($viewModel.pokemonCellItems) { item in
                    Text("Item \(item)")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

#Preview {
    let appDependencies = AppDependencies(networkProvider: NetworkProvider())
    return PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: appDependencies.getPokemonListUseCase,
                                            getPokemonUseCase: appDependencies.getPokemonUseCase))
}
