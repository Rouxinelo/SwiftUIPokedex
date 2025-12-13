//
//  Router.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case pokemonDetail(any PokemonRepresentable)
    
    static func == (lhs: Route, rhs: Route) -> Bool {
        switch (lhs, rhs) {
        case let (.pokemonDetail(l), .pokemonDetail(r)):
            return l.id == r.id
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .pokemonDetail(pokemon):
            hasher.combine(pokemon.id)
        }
    }
}

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    static let shared: Router = Router()
    
    func navigate(to route: Route) {
        path.append(route)
    }
}
