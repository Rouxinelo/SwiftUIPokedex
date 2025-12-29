//
//  PokemonStat.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 26/12/2025.
//

import Foundation

enum PokemonStat: String {
    case attack, hp, defense, speed
    case specialDefense = "special-defense"
    case specialAttack = "special-attack"
    
    var maxValue: CGFloat {
        switch self {
        case .attack:
            190
        case .hp:
            255
        case .defense:
            230
        case .speed:
            180
        case .specialDefense:
            230
        case .specialAttack:
            194
        }
    }
}
