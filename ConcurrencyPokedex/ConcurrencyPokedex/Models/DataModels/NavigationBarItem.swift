//
//  NavigationBarItem.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 08/12/2025.
//

import Foundation

struct NavigationBarItem {
    var name: String
    var image: String
    var action: () -> Void
}

extension NavigationBarItem: Hashable, Identifiable {
    static func == (lhs: NavigationBarItem, rhs: NavigationBarItem) -> Bool {
        lhs.name == rhs.name && lhs.image == rhs.image
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: String {
        name
    }
}
