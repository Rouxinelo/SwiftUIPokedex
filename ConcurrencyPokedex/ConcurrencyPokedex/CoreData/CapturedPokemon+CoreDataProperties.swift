//
//  CapturedPokemon+CoreDataProperties.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 14/06/2026.
//
//

public import Foundation
public import CoreData


public typealias CapturedPokemonCoreDataPropertiesSet = NSSet

extension CapturedPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CapturedPokemon> {
        return NSFetchRequest<CapturedPokemon>(entityName: "CapturedPokemon")
    }

    @NSManaged public var dateCaptured: Date?
    @NSManaged public var id: Int16
}

extension CapturedPokemon : Identifiable {

}
