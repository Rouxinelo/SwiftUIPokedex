//
//  PokemonDetailView.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 09/12/2025.
//

import SwiftUI

struct PokemonDetailView: View {
    enum Constants {
        static let placeholder = "pokeball"
    }
    
    var pokemon: any PokemonRepresentable
    
    var body: some View {
        VStack(spacing: 0) {
            navigationBar
            VStack {
                Text(pokemon.name.capitalized)
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(getIdString(id: pokemon.id))
                    .foregroundColor(.white)
                    .font(.title2)
                HStack {
                    getTypeCell(text: pokemon.types.first?.type.name ?? "")
                    if pokemon.types.count > 1, let secondType = pokemon.types.last?.type.name {
                        getTypeCell(text: secondType)
                    }
                }
                ZStack {
                    AsyncImage(url: URL(string: pokemon.sprites.frontDefault ?? "")) { phase in
                        switch phase {
                        case .empty, .failure(_):
                            getPlaceholderPokeball()
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .containerRelativeFrame(.horizontal)
                        @unknown default:
                            getPlaceholderPokeball()
                        }
                    }
                }
            }
            .padding(.top)
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            .background(PokemonType(rawValue: pokemon.types.first?.type.name ?? "")?.displayColor ?? .secondary)
            
            VStack {
                Text("example2")
                    .padding()
                    .frame(maxHeight: .infinity)
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    var navigationBar: some View {
        NavigationBar(title: "Detail",
                      buttons: [NavigationBarItem(name: "Close",
                                                  image: "xmark",
                                                  action: {
            Router.shared.path.removeLast() })],
                      isWhiteFont: true,
                      backgroundColor: getBackgroundColor(pokemon: pokemon))
    }
    
    @ViewBuilder
    func getTypeCell(text: String) -> some View {
        Text(text.capitalized)
            .padding(.vertical, 4)
            .padding(.horizontal, 10)
            .frame(width: 80)
            .background(PokemonType(rawValue: text)?.displayColor ?? .gray)
            .clipShape(Capsule())
            .shadow(radius: 2)
            .font(.footnote)
            .fontWeight(.bold)
            .foregroundStyle(.white)
    }
    
    func getBackgroundColor(pokemon: any PokemonRepresentable) -> Color {
        guard let firstType = pokemon.types.first?.type.name,
              let type = PokemonType(rawValue: firstType) else { return .gray }
        return type.displayColor
    }
    
    @ViewBuilder
    func getPlaceholderPokeball() -> some View {
        Image(Constants.placeholder)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 70)
    }
    
    func getIdString(id: Int) -> String {
        String(format: "#%03d", id)
    }
}

#Preview {
    PokemonDetailView(pokemon: PokemonDTO(id: 1,
                                          name: "bulbasaur",
                                          height: 10, weight: 10,
                                          baseExperience: 0,
                                          abilities: [],
                                          forms: [],
                                          stats: [],
                                          types: [PokemonTypeDTO(slot: 1,
                                                                 type: NamedAPIResourceDTO(name: "grass",
                                                                                           url: ""))],
                                          sprites: PokemonSpritesDTO(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png",
                                                                     backDefault: "",
                                                                     frontShiny: "",
                                                                     backShiny: ""),
                                          moves: []))
}
