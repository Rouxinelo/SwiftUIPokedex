//
//  PokemonRepresentable.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol PokemonRepresentable: Codable {
    associatedtype Abilities: PokemonAbilityRepresentable
    associatedtype Forms: NamedAPIResourceRepresentable
    associatedtype Stats: PokemonStatRepresentable
    associatedtype Types: PokemonTypeRepresentable
    associatedtype Sprites: PokemonSpritesRepresentable
    associatedtype Moves: PokemonMoveRepresentable

    var  id: Int { get }
    var name: String { get }
    var height: Int { get }
    var weight: Int { get }
    var baseExperience: Int? { get }
    var abilities: [Abilities] { get }
    var forms: [Forms] { get }
    var stats: [Stats] { get }
    var types: [Types] { get }
    var sprites: Sprites { get }
    var moves: [Moves] { get }
}

protocol PokemonAbilityRepresentable: Codable {
    associatedtype Ability: NamedAPIResourceRepresentable
    
    var ability: Ability { get }
    var isHidden: Bool { get }
    var slot: Int { get }
}

protocol PokemonStatRepresentable: Codable {
    associatedtype Stat: NamedAPIResourceRepresentable
    
    var baseStat: Int { get }
    var effort: Int { get }
    var stat: Stat { get }
}

protocol PokemonTypeRepresentable: Codable {
    associatedtype Types: NamedAPIResourceRepresentable
    
    var slot: Int { get }
    var type: Types { get }
}

protocol PokemonMoveRepresentable: Codable {
    associatedtype Move: NamedAPIResourceRepresentable
    associatedtype VersionGroupDetails: MoveVersionGroupDetailRepresentable
    
    var move: Move { get }
    var versionGroupDetails: [VersionGroupDetails] { get }
}

protocol MoveVersionGroupDetailRepresentable: Codable {
    associatedtype VersionGroup: NamedAPIResourceRepresentable
    associatedtype MoveLearnMethod: NamedAPIResourceRepresentable
    
    var levelLearnedAt: Int { get }
    var versionGroup: VersionGroup { get }
    var moveLearnMethod: MoveLearnMethod { get }
}

protocol NamedAPIResourceRepresentable: Codable {
    var name: String { get }
    var url: String { get }
}

protocol PokemonSpritesRepresentable: Codable {
    var frontDefault: String? { get }
    var backDefault: String? { get }
    var frontShiny: String? { get }
    var backShiny: String? { get }
}
