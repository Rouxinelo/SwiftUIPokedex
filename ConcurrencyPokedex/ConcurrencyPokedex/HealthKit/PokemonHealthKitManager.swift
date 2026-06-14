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
}

class PokemonHealthKitManager {
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
        guard let stepType = HKQuantityType.quantityType(forIdentifier: .stepCount) else { return }

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
            guard let self = self, let statsCollection = results else { return }

            statsCollection.enumerateStatistics(from: startDate, to: endDate) { stats, _ in
                let steps = stats.sumQuantity()?.doubleValue(for: .count()) ?? 0
                numberOfPokeballs += self.getPokeballsPerDay(for: steps)
            }
            completion(numberOfPokeballs)
        }
        healthStore.execute(query)
    }
    
    func shouldUpdatePokeballStatus() -> Bool {
        guard let lastAccessDate = userDefaults?.value(forKey: PokedexUserDataConstants.appAccessDateKey) as? Date else { return false }
        return Calendar.current.isDateInToday(lastAccessDate)
    }
    
    func storeLastAccessDate() {
        userDefaults?.setValue(Date(), forKey: PokedexUserDataConstants.appAccessDateKey)
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
}
