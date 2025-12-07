//
//  PokemonListDTO.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

struct PokemonListDTO: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonEntryDTO]
}

struct PokemonEntryDTO: Codable {
    let name: String
    let url: String
}
