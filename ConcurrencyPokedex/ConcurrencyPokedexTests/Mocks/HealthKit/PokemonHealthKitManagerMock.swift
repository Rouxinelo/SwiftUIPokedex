//
//  PokemonHealthKitManagerMock.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 14/06/2026.
//

@testable import ConcurrencyPokedex
import Foundation

struct PokemonHealthKitManagerMock: PokemonHealthKitManagerProtocol {
    func requestHealthPermissionsAuthorization(completion: @escaping (Bool, (any Error)?) -> Void) {}
    
    func getTotalNumberOfPokeballs(startDate: Date, endDate: Date, completion: @escaping (Int) -> Void) {}
    
    func shouldUpdatePokeballStatus() -> Bool { true }
    
    func storeLastAccessDate() {}
    
    func getPokeballsPerDay(for stepCount: Double) -> Int { return 1 }
}
