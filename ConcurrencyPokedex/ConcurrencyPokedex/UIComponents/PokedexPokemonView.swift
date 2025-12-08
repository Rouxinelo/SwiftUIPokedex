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
                                Text(firstType)
                                    .frame(width: 50)
                                    .background(Color.secondary)
                                    .clipShape(RoundedRectangle(cornerRadius: 20))
                                if let secondType = secondType {
                                    Text(secondType)
                                        .frame(width: 50)
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
                                        .frame(width: 70, height: 70)

                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 80, height: 50)
                                @unknown default:
                                    Image("poke ball")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 50, height: 50)
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
            .padding(.leading, 15)
            .padding(.trailing, 5)
        }
        .frame(width: getCellWidth(), height: 120)
        .background(Color.red.opacity(0.7))
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
}

#Preview {
    HStack {
        PokedexPokemonView(number: 111,
                           name: "Crabominable",
                           firstType: "Fire",
                           secondType: "Water",
                           imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3wd21.png")
        PokedexPokemonView(number: 1,
                           name: "Name",
                           firstType: "Fire",
                           secondType: "Water",
                           imageURL: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/30.png")
    }
}
