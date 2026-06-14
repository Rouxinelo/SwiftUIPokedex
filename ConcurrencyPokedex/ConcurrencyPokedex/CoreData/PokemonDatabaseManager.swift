//
//  DatabaseHandler.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 29/12/2025.
//

import Foundation
import CoreData

struct PokemonDatabaseManager {
    var context: NSManagedObjectContext
    
    func saveCapturedPokemon(id: Int, captureDate: Date) -> Bool {
        guard !isPokemonCaptured(id: id) else { return false }
        let capturedPokemon = CapturedPokemon(context: context)
        capturedPokemon.id = Int16(id)
        capturedPokemon.dateCaptured = captureDate
        
        do {
            try context.save()
            return true
        } catch {
            return false
        }
    }
    
    func getCapturedPokemon() -> [Int] {
        let request: NSFetchRequest<CapturedPokemon> = CapturedPokemon.fetchRequest()
        do {
            let capturedPokemon = try context.fetch(request)
            return capturedPokemon.map { Int($0.id) }
        } catch {
            return []
        }
    }
    
    func isPokemonCaptured(id: Int) -> Bool {
        let request: NSFetchRequest<CapturedPokemon> = CapturedPokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        request.fetchLimit = 1
        do {
            return try context.count(for: request) > 0
        } catch {
            return false
        }
    }
    
    func deletePokemon(id: Int) -> Bool {
        guard isPokemonCaptured(id: id) else { return false }
        let request: NSFetchRequest<CapturedPokemon> = CapturedPokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", NSNumber(value: id))
        
        do {
            let results = try context.fetch(request)
            for pokemon in results { context.delete(pokemon) }
            try context.save()
            return true
        } catch {
            return false
        }
    }
}
