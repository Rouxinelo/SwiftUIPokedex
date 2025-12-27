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
    var isFavorite: Bool
    
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
            .padding(.top)
            .frame(maxWidth: .infinity)
            .frame(height: 250)
            
            VStack {
                VStack(spacing: 10) {
                    Text("Stats")
                        .font(.headline)
                    HStack(spacing: 20) {
                        getPokemonDimension(image: "ruler",
                                            statText: getFormattedHeight(height: pokemon.height))
                        getPokemonDimension(image: "scalemass",
                                            statText: getFormattedWeight(weight: pokemon.weight))
                    }
                    .font(.subheadline)
                }
                .padding()
                
                VStack {
                    StatBar(statName: "HP", statColor: .red, statValue: getStatValue(desiredStat: .hp), statMax: PokemonStat.hp.maxValue)
                    StatBar(statName: "ATK", statColor: .orange, statValue: getStatValue(desiredStat: .attack), statMax: PokemonStat.attack.maxValue)
                    StatBar(statName: "DEF", statColor: .blue, statValue: getStatValue(desiredStat: .defense), statMax: PokemonStat.defense.maxValue)
                    StatBar(statName: "SATK", statColor: .purple, statValue: getStatValue(desiredStat: .specialAttack), statMax: PokemonStat.specialAttack.maxValue)
                    StatBar(statName: "SDEF", statColor: .green, statValue: getStatValue(desiredStat: .specialDefense), statMax: PokemonStat.specialDefense.maxValue)
                    StatBar(statName: "SPD", statColor: .yellow, statValue: getStatValue(desiredStat: .speed), statMax: PokemonStat.speed.maxValue)
                }
                
                VStack {
                    Text("Status")
                        .font(.headline)
                    Text(isFavorite ? "Captured on 23 December 2024" : "Not captured")
                }
                .padding()
                VStack {
                    Spacer()
                    ImageButton(imageName: "pokeball",
                                text: "Capture",
                                backgroundColor: backgroundColor,
                                onClick: {})
                }
                .padding(.bottom, 20)
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(.white)
            .clipShape(.rect(topLeadingRadius: 20,
                             topTrailingRadius: 20,
                             style: .continuous))
            .shadow(radius: 5)
        }
        .background(backgroundColor)
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(edges: .bottom)
    }
}

private extension PokemonDetailView {
    var navigationBar: some View {
        NavigationBar(title: "Detail",
                      buttons: [NavigationBarItem(name: "Close",
                                                  image: "xmark",
                                                  action: {
            Router.shared.path.removeLast() })],
                      isWhiteFont: true,
                      backgroundColor: .clear)
    }
    
    var backgroundColor: Color {
        guard let firstType = pokemon.types.first?.type.name,
              let type = PokemonType(rawValue: firstType) else { return .gray }
        return type.displayColor
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
    
    @ViewBuilder
    func getPlaceholderPokeball() -> some View {
        Image(Constants.placeholder)
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 70)
            .containerRelativeFrame(.horizontal)
    }
    
    @ViewBuilder
    func getPokemonDimension(image: String, statText: String) -> some View {
        HStack(spacing: 0) {
            Image(systemName: image)
            Text(statText)
        }
    }
    
    func getIdString(id: Int) -> String {
        String(format: "#%03d", id)
    }
    
    func getFormattedHeight(height: Int) -> String {
        "\(getFormattedResult(value: Double(height) / 10.0)) m"
    }
    
    func getFormattedWeight(weight: Int) -> String {
        "\(getFormattedResult(value: Double(weight) / 10.0)) kg"
    }
    
    func getFormattedResult(value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    func getStatValue(desiredStat: PokemonStat) -> CGFloat {
        guard let stat = pokemon.stats.first(where: { $0.stat.name == desiredStat.rawValue }) else { return 0 }
        return CGFloat(stat.baseStat)
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
                                          moves: []),
                      isFavorite: false)
}
