//
//  PokedexPokemonItem.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import Foundation

struct PokedexPokemonItem: Identifiable {
    var id: Int
    var sprite: String
    var name: String
    var firstType: String
    var secondType: String?
}
