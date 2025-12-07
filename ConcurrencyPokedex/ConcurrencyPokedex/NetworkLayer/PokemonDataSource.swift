//
//  PokemonDataSource.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol PokemonDataSourceProtocol {
    func getPokemonList(limit: Int, offset: Int)
    func getPokemon(id: Int)
}
