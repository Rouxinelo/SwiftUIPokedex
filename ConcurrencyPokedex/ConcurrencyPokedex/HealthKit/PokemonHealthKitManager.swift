//
//  PokemonHealthKitManager.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 31/12/2025.
//

import Foundation
import HealthKit

enum PokedexUserDataConstants {
    static let appAccessDateKey = "appAccessDate"
    static let currentPokeballsKey = "currentPokeballs"
}

protocol PokemonHealthKitManagerProtocol {
    func requestHealthPermissionsAuthorization(completion: @escaping(Bool, Error?) -> Void)
    func getTotalNumberOfPokeballs(startDate: Date,
                                   endDate: Date,
                                   completion: @escaping(Int) -> Void)
    func shouldUpdatePokeballStatus() -> Bool
    func storeLastAccessDate(_ date: Date)
    func getLastAccessDate() -> Date
    func getPokeballsPerDay(for stepCount: Double) -> Int
    func getAvailablePokeballs() -> Int
    func storePokeballs(_ newPokeballs: Int)
}

class PokemonHealthKitManager: PokemonHealthKitManagerProtocol {
    let userDefaults: UserDefaults?
    let healthStore = HKHealthStore()
    
    init(userDefaults: UserDefaults?) {
        self.userDefaults = userDefaults
    }
    
    func requestHealthPermissionsAuthorization(completion: @escaping(Bool, Error?) -> Void) {
        healthStore.requestAuthorization(toShare: nil,
                                         read: [HKQuantityType(.stepCount)],
                                         completion: completion)
    }
    
    func getTotalNumberOfPokeballs(startDate: Date,
                                   endDate: Date,
                                   completion: @escaping(Int) -> Void) {
        guard HKHealthStore.isHealthDataAvailable(),
              let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else {
            completion(0)
            return
        }
        
        var numberOfPokeballs = 0
        
        let predicate = HKQuery.predicateForSamples(
            withStart: startDate,
            end: endDate,
            options: .strictStartDate
        )
        
        let calendar = Calendar.current
        let anchorDate = calendar.startOfDay(for: startDate)
        
        let query = HKStatisticsCollectionQuery(
            quantityType: stepType,
            quantitySamplePredicate: predicate,
            options: .cumulativeSum,
            anchorDate: anchorDate,
            intervalComponents: DateComponents(day: 1)
        )
        
        query.initialResultsHandler = { [weak self] _, results, error in
            guard let self = self, let statsCollection = results else {
                completion(0)
                return
            }
            
            if let error = error {
                completion(0)
                return
            }
            
            statsCollection.enumerateStatistics(from: startDate, to: endDate) { stats, _ in
                let steps = stats.sumQuantity()?.doubleValue(for: .count()) ?? 0
                numberOfPokeballs += self.getPokeballsPerDay(for: steps)
            }
            completion(numberOfPokeballs)
        }
        healthStore.execute(query)
    }
    
    func shouldUpdatePokeballStatus() -> Bool {
        guard let lastAccessDate = userDefaults?.value(forKey: PokedexUserDataConstants.appAccessDateKey) as? Date else {
            storeLastAccessDate()
            return false
        }
        return !Calendar.current.isDateInToday(lastAccessDate)
    }
    
    func storeLastAccessDate(_ date: Date = Date()) {
        userDefaults?.setValue(date,
                               forKey: PokedexUserDataConstants.appAccessDateKey)
    }
    
    func getLastAccessDate() -> Date {
        userDefaults?.value(forKey: PokedexUserDataConstants.appAccessDateKey) as? Date ?? Date()
    }
    
    func getPokeballsPerDay(for stepCount: Double) -> Int {
        switch stepCount {
        case 0..<3000:
            return 0
        case 3000..<5000:
            return 1
        case 5000..<7500:
            return 2
        default:
            return 3
        }
    }
    
    func getAvailablePokeballs() -> Int {
        userDefaults?.integer(forKey: PokedexUserDataConstants.currentPokeballsKey) ?? 0
    }
    
    func storePokeballs(_ newPokeballs: Int) {
        let pokeballsToStore = newPokeballs + getAvailablePokeballs()
        userDefaults?.set(pokeballsToStore,
                          forKey: PokedexUserDataConstants.currentPokeballsKey)
    }
}
