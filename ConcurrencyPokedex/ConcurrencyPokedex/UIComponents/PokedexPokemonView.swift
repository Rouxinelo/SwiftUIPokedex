//
//  PokedexPokemonView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import SwiftUI

struct PokedexPokemonView: View {
    var number: Int
    var name: String
    var firstType: String
    var secondType: String?
    var imageURL: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    VStack(alignment: .leading) {
                        Text(getIdString(id: number))
                        Text(name)
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                    HStack {
                        VStack {
                            Spacer()
                            VStack(alignment: .leading, spacing: 5) {
                                Text(firstType.capitalized)
                                    .frame(width: 65)
                                    .background(Color.secondary)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                if let secondType = secondType {
                                    Text(secondType.capitalized)
                                        .frame(width: 65)
                                        .background(Color.secondary)
                                        .clipShape(RoundedRectangle(cornerRadius: 20))
                                }
                            }
                            .font(.footnote)
                            .fontWeight(.bold)
                        }
                        
                        Spacer()

                        VStack {
                            Spacer()
                            AsyncImage(url: URL(string: imageURL)) { phase in
                                switch phase {
                                case .empty, .failure(_):
                                    Image("pokeball")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 70)

                                case .success(let image):
                                    image
                                        .aspectRatio(1, contentMode: .fit)
                                        .frame(width: 70, height: 70)
                                        .scaledToFit()
                                        .background(Color.white.opacity(0.0))
                                @unknown default:
                                    Image("pokeball")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 70)
                                }
                            }
                        }
                    }
                }
                .foregroundStyle(.white)
                .foregroundStyle(.white)
                .font(.caption)
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
}

#Preview {
    HStack {
        PokedexPokemonView(number: 9,
                           name: "Blastoise",
                           firstType: "water",
                           imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/qq9.png")
        PokedexPokemonView(number: 6,
                           name: "Charizard",
                           firstType: "fire",
                           secondType: "flying",
                           imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/6.png")
    }
}
