//
//  PokemonListDTO.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

struct PokemonListDTO: Codable, PokemonListRepresentable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntryDTO]
}

struct PokemonEntryDTO: Codable, PokemonEntryRepresentable {
    let name: String
    let url: String
}
