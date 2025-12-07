//
//  PokemonRepresentable.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

struct PokemonRepresentable: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let baseExperience: Int?
    let abilities: [PokemonAbilityRepresentable]
    let forms: [NamedAPIResourceRepresentable]
    let stats: [PokemonStatRepresentable]
    let types: [PokemonTypeRepresentable]
    let sprites: PokemonSpritesRepresentable
    let moves: [PokemonMoveRepresentable]

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, abilities, forms, stats, types, moves, sprites
        case baseExperience = "base_experience"
    }
}

struct PokemonAbilityRepresentable: Codable {
    let ability: NamedAPIResourceRepresentable
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct PokemonStatRepresentable: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResourceRepresentable

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonTypeRepresentable: Codable {
    let slot: Int
    let type: NamedAPIResourceRepresentable
}

struct PokemonMoveRepresentable: Codable {
    let move: NamedAPIResourceRepresentable
    let versionGroupDetails: [MoveVersionGroupDetailRepresentable]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct MoveVersionGroupDetailRepresentable: Codable {
    let levelLearnedAt: Int
    let versionGroup: NamedAPIResourceRepresentable
    let moveLearnMethod: NamedAPIResourceRepresentable

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }
}

struct NamedAPIResourceRepresentable: Codable {
    let name: String
    let url: String
}

struct PokemonSpritesRepresentable: Codable {
    let frontDefault: String?
    let backDefault: String?
    let frontShiny: String?
    let backShiny: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case backDefault = "back_default"
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
}
