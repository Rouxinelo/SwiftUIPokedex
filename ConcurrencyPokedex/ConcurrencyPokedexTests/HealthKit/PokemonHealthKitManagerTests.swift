//
//  PokemonHealthKitManager.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 31/12/2025.
//

import XCTest
@testable import ConcurrencyPokedex

final class PokemonHealthKitManagerTests: XCTestCase {
    var userDefaults = UserDefaults(suiteName: "pokemon.healthKit.tests")
    
    override func tearDownWithError() throws {
        userDefaults?.removePersistentDomain(forName: "pokemon.healthKit.tests")
    }

    func test_getPokeballsPerDay_whenMultipleValuesAreCalled() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        
        let zeroPokeball = sut.getPokeballsPerDay(for: 0)
        let onePokeball = sut.getPokeballsPerDay(for: 3000)
        let twoPokeball = sut.getPokeballsPerDay(for: 5000)
        let threePokeball = sut.getPokeballsPerDay(for: 7500)
        
        XCTAssertEqual(zeroPokeball, 0)
        XCTAssertEqual(onePokeball, 1)
        XCTAssertEqual(twoPokeball, 2)
        XCTAssertEqual(threePokeball, 3)
    }
    
    func test_shouldUpdatePokeballStatus_whenNoValuesAreStored_shouldReturnFalse() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        let result = sut.shouldUpdatePokeballStatus()
        
        XCTAssertFalse(result)
    }
    
    func test_shouldUpdatePokeballStatus_whenValuesAreStoredInUserDefaults_shouldReturnTrue() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        sut.storeLastAccessDate()
        let result = sut.shouldUpdatePokeballStatus()
        
        XCTAssertTrue(result)
    }
}
