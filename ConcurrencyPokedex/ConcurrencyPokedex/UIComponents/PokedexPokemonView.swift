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
    var number: Int
    var name: String
    var firstType: String
    var secondType: String?
    var imageURL: String
    
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
                                AsyncImage(url: URL(string: imageURL)) { phase in
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
                            Text(name)
                                .font(.headline)
                                .fontWeight(.bold)
                            Text(getIdString(id: number))
                        }
                        HStack {
                            VStack {
                                Spacer()
                                VStack(alignment: .leading, spacing: 5) {
                                    getTypeCell(text: firstType)
                                    if let secondType = secondType {
                                        getTypeCell(text: secondType)
                                    }
                                }
                                .font(.footnote)
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
        .background(getBackgroundColor(for: PokemonType(rawValue: firstType)))
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
            .frame(width: 65)
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

#Preview {
    HStack {
        PokedexPokemonView(number: 9,
                           name: "Blastoise",
                           firstType: "water",
                           imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/9.png")
        PokedexPokemonView(number: 6,
                           name: "Charizard",
                           firstType: "fire",
                           secondType: "flying",
                           imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")
    }
}
