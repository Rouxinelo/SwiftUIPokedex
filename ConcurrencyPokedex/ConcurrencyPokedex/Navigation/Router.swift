//
//  Router.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import Foundation
import SwiftUI

enum Route: Hashable {
    case pokemonDetail
}

class Router: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
    static let shared: Router = Router()
    
    func navigate(to route: Route) {
        path.append(route)
    }
}
