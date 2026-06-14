//
//  PokemonListRepresentable.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol PokemonListRepresentable {
    associatedtype Entry: PokemonEntryRepresentable

    var count: Int { get }
    var next: String? { get }
    var previous: String? { get }
    var results: [Entry] { get }
}

protocol PokemonEntryRepresentable {
    var name: String { get }
    var url: String { get }
}
