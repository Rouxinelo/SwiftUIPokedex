//
//  PokemonDTO.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

struct PokemonDTO: Codable, PokemonRepresentable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let baseExperience: Int?
    let abilities: [PokemonAbilityDTO]
    let forms: [NamedAPIResourceDTO]
    let stats: [PokemonStatDTO]
    let types: [PokemonTypeDTO]
    let sprites: PokemonSpritesDTO
    let moves: [PokemonMoveDTO]

    enum CodingKeys: String, CodingKey {
        case id, name, height, weight, abilities, forms, stats, types, moves, sprites
        case baseExperience = "base_experience"
    }
}

struct PokemonAbilityDTO: Codable, PokemonAbilityRepresentable {
    let ability: NamedAPIResourceDTO
    let isHidden: Bool
    let slot: Int

    enum CodingKeys: String, CodingKey {
        case ability
        case isHidden = "is_hidden"
        case slot
    }
}

struct PokemonStatDTO: Codable {
    let baseStat: Int
    let effort: Int
    let stat: NamedAPIResourceDTO

    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case effort
        case stat
    }
}

struct PokemonTypeDTO: Codable {
    let slot: Int
    let type: NamedAPIResourceDTO
}

struct PokemonMoveDTO: Codable {
    let move: NamedAPIResourceDTO
    let versionGroupDetails: [MoveVersionGroupDetailDTO]

    enum CodingKeys: String, CodingKey {
        case move
        case versionGroupDetails = "version_group_details"
    }
}

struct MoveVersionGroupDetailDTO: Codable {
    let levelLearnedAt: Int
    let versionGroup: NamedAPIResourceDTO
    let moveLearnMethod: NamedAPIResourceDTO

    enum CodingKeys: String, CodingKey {
        case levelLearnedAt = "level_learned_at"
        case versionGroup = "version_group"
        case moveLearnMethod = "move_learn_method"
    }
}

struct NamedAPIResourceDTO: Codable {
    let name: String
    let url: String
}

struct PokemonSpritesDTO: Codable {
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
