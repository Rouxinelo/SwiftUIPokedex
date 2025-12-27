//
//  PokemonListRepresentableMock.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 27/12/2025.
//

import Foundation
@testable import ConcurrencyPokedex

struct PokemonListRepresentableMock: PokemonListRepresentable {
    var results = [PokemonEntryRepresentableMock]()
    var count: Int = 0
    var next: String?
    var previous: String?
}

struct PokemonEntryRepresentableMock: PokemonEntryRepresentable {
    var name: String = ""
    var url: String = ""
}
