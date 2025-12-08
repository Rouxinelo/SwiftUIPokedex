//
//  PokemonType.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import Foundation
import SwiftUI

enum PokemonType: String {
    case normal
    case fire
    case water
    case electric
    case grass
    case ice
    case fighting
    case poison
    case ground
    case flying
    case psychic
    case bug
    case rock
    case ghost
    case dragon
    case dark
    case steel
    case fairy
    
    var displayName: String {
        self.rawValue.capitalized
    }
    
    var displayColor: Color {
        switch self {
        case .normal: return Color(red: 168/255, green: 168/255, blue: 120/255)
        case .fire: return Color.red
        case .water: return Color.blue
        case .electric: return Color.yellow
        case .grass: return Color.green
        case .ice: return Color(red: 152/255, green: 216/255, blue: 216/255)
        case .fighting: return Color(red: 192/255, green: 48/255, blue: 40/255)
        case .poison: return Color.purple
        case .ground: return Color.brown
        case .flying: return Color(red: 168/255, green: 144/255, blue: 240/255)
        case .psychic: return Color(red: 248/255, green: 88/255, blue: 136/255)
        case .bug: return Color(red: 168/255, green: 184/255, blue: 32/255)
        case .rock: return Color(red: 184/255, green: 160/255, blue: 56/255)
        case .ghost: return Color(red: 112/255, green: 88/255, blue: 152/255)
        case .dragon: return Color(red: 112/255, green: 56/255, blue: 248/255)
        case .dark: return Color(red: 112/255, green: 88/255, blue: 72/255)
        case .steel: return Color(red: 184/255, green: 184/255, blue: 208/255)
        case .fairy: return Color(red: 238/255, green: 153/255, blue: 172/255)
        }
    }
}
