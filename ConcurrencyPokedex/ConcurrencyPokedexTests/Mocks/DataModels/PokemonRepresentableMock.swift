//
//  PokemonRepresentableMock.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 27/12/2025.
//

import Foundation
@testable import ConcurrencyPokedex

struct PokemonRepresentableMock: PokemonRepresentable {
    var id: Int = 1
    var name: String = "example"
    var height: Int = 1
    var weight: Int = 1
    var baseExperience: Int? = 1
    var abilities = [PokemonAbilityRepresentableMock]()
    var forms = [NamedAPIResourceRepresentableMock]()
    var stats = [PokemonStatRepresentableMock()]
    var types = [PokemonTypeRepresentableMock()]
    var moves = [PokemonMoveRepresentableMock()]
    var sprites = PokemonSpritesRepresentableMock()
}

struct PokemonAbilityRepresentableMock: PokemonAbilityRepresentable {
    var ability = NamedAPIResourceRepresentableMock()
    var isHidden: Bool = false
    var slot: Int = 1
}

struct NamedAPIResourceRepresentableMock: NamedAPIResourceRepresentable {
    var name: String = ""
    var url: String = ""
}

struct PokemonStatRepresentableMock: PokemonStatRepresentable {
    var stat = NamedAPIResourceRepresentableMock()
    var baseStat: Int = 0
    var effort: Int = 0
}

struct PokemonTypeRepresentableMock: PokemonTypeRepresentable {
    var type = NamedAPIResourceRepresentableMock(name: "fire")
    var slot: Int = 1
}

struct PokemonSpritesRepresentableMock: PokemonSpritesRepresentable {
    var frontDefault: String?
    var backDefault: String?
    var frontShiny: String?
    var backShiny: String?
}

struct PokemonMoveRepresentableMock: PokemonMoveRepresentable {
    var move = NamedAPIResourceRepresentableMock()
    var versionGroupDetails = [MoveVersionGroupDetailRepresentableMock]()
}

struct MoveVersionGroupDetailRepresentableMock: Codable, MoveVersionGroupDetailRepresentable {
    var levelLearnedAt: Int = 1
    var versionGroup = NamedAPIResourceRepresentableMock()
    var moveLearnMethod = NamedAPIResourceRepresentableMock()
}
