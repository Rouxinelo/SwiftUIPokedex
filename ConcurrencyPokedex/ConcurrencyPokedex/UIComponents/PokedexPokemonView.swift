//
//  PokedexPokemonView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

struct PokedexPokemonView: View {
    enum Constants {
        static let placeholder = "pokeball"
    }
    var pokemon: any PokemonRepresentable
    
    init(pokemon: any PokemonRepresentable) {
        self.pokemon = pokemon
    }
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            ZStack {
                                Circle()
                                    .fill(.white.opacity(0.1))
                                    .frame(width: 90, height: 90)
                                AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { phase in
                                    switch phase {
                                    case .empty, .failure(_):
                                        getPlaceholderPokeball()
                                    case .success(let image):
                                        image
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 70, height: 70)
                                            .scaledToFit()
                                            .background(Color.white.opacity(0.0))
                                    @unknown default:
                                        getPlaceholderPokeball()
                                    }
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        VStack(alignment: .leading) {
                            Text(pokemon.name.capitalized)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text(getIdString(id: pokemon.id))
                        }
                        HStack {
                            VStack {
                                Spacer()
                                VStack(alignment: .leading, spacing: 5) {
                                    getTypeCell(text: pokemon.types.first?.type.name ?? "")
                                    if pokemon.types.count > 1, let secondType = pokemon.types.last?.type.name {
                                        getTypeCell(text: secondType)
                                    }
                                }
                                .font(.microFootNote)
                                .fontWeight(.bold)
                            }
                            Spacer()
                        }
                    }
                    .foregroundStyle(.white)
                    .font(.caption)
                }
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 5)
        }
        .frame(width: getCellWidth(), height: 120)
        .background(getBackgroundColor(for: PokemonType(rawValue: pokemon.types.first?.type.name ?? "")))
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 5)
        .padding(5)
    }
    
    func getIdString(id: Int) -> String {
        String(format: "#%03d", id)
    }
    
    func getCellWidth() -> CGFloat {
        UIScreen.main.bounds.width / 2 - 15
    }
    
    func getBackgroundColor(for type: PokemonType?) -> Color {
        guard let type = type else { return .accentColor }
        return type.displayColor.opacity(0.7)
    }
    
    @ViewBuilder
    func getTypeCell(text: String) -> some View {
        Text(text.capitalized)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .frame(width: 70)
            .background(PokemonType(rawValue: text)?.displayColor ?? .gray)
            .clipShape(Capsule())
            .shadow(radius: 2)
    }
    
    @ViewBuilder
    func getPlaceholderPokeball() -> some View {
        Image(Constants.placeholder)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 70)
    }
}
