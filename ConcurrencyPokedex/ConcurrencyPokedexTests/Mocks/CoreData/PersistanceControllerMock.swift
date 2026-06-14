//
//  PersistanceControllerMock.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 30/12/2025.
//

import Foundation
import CoreData

struct PersistanceControllerMock {
    var persistentContainer: NSPersistentContainer = {
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        let container = NSPersistentContainer(name: "PokemonModel")
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
