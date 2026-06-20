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
    
    func test_shouldUpdatePokeballStatus_whenTodayDateIsStored_shouldReturnFalse() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        sut.storeLastAccessDate()
        let result = sut.shouldUpdatePokeballStatus()
        
        XCTAssertFalse(result)
    }
    
    func test_shouldUpdatePokeballStatus_whenPastDateIsStored_shouldReturnTrue() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        let yesterdayDate = Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
        sut.storeLastAccessDate(yesterdayDate)
        let result = sut.shouldUpdatePokeballStatus()
        
        XCTAssertTrue(result)
    }
    
    func test_getLastAccessDate_whenDateSetIsCurrent_then_shouldReturnCurrentDate() {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        let todayDate = Date()
        sut.storeLastAccessDate(todayDate)
        let lastAccessDate = sut.getLastAccessDate()
        
        XCTAssertEqual(todayDate, lastAccessDate)
    }
    
    func test_getAvailablePokeballs_whenNoValuesAreStored_shouldReturnZero() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        let result = sut.getAvailablePokeballs()
        
        XCTAssertEqual(result, 0)
    }
    
    func test_getAvailablePokeballs_whenPokeballsAreStored_shouldReturnValue() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        let pokeballsToStore = 10
        sut.storePokeballs(pokeballsToStore)
        let result = sut.getAvailablePokeballs()
        
        XCTAssertEqual(result, pokeballsToStore)
    }
    
    func test_getAvailablePokeballs_whenPokeballsAreStoredMultipleTimes_shouldReturnSumOfValues() throws {
        let sut = PokemonHealthKitManager(userDefaults: userDefaults)
        let pokeballsToStore = [10, 20, 30]
        pokeballsToStore.forEach { sut.storePokeballs($0) }
        let result = sut.getAvailablePokeballs()
        let expectedResult = pokeballsToStore.reduce(0, +)
        
        XCTAssertEqual(result, expectedResult)
    }
}
