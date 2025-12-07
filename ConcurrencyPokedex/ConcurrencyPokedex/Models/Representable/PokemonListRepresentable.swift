//
//  PokemonListRepresentable.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

struct PokemonListRepresentable: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntryRepresentable]
}

struct PokemonEntryRepresentable: Codable {
    let name: String
    let url: String
}
