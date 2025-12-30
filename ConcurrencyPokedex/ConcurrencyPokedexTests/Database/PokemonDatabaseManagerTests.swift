//
//  PokemonDatabaseManagerTests.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 30/12/2025.
//

import XCTest
import CoreData
@testable import ConcurrencyPokedex

final class PokemonDatabaseManagerTests: XCTestCase {
    var persistanceController = PersistanceControllerMock()
    
    override func setUpWithError() throws {
        persistanceController = PersistanceControllerMock()
    }
    
    func test_isPokemonCaptured_withEmptyDatabase_shouldReturnFalse() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let result = sut.isPokemonCaptured(id: 1)
        XCTAssertFalse(result)
    }
    
    func test_isPokemonCaptured_afterAddingToDatabase_shouldReturnTrue() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let resultBeforeAdding = sut.isPokemonCaptured(id: 1)
        let insert = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        let resultAfterAdding = sut.isPokemonCaptured(id: 1)
        XCTAssertFalse(resultBeforeAdding)
        XCTAssertTrue(insert)
        XCTAssertTrue(resultAfterAdding)
    }
    
    func test_saveCapturedPokemonToDatabase() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let result = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        XCTAssertTrue(result)
    }
    
    func test_saveCapturedPokemonToDatabase_whenIdWasAlreadyInDatabase_shouldReturnFalseInDuplicated() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let firstInsert = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        let duplicatedInsert = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        XCTAssertTrue(firstInsert)
        XCTAssertFalse(duplicatedInsert)
    }
    
    func test_saveCapturedPokemonToDatabse_whenSavingDifferentPokemon() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let firstInsert = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        let secondInsert = sut.saveCapturedPokemon(id: 2, captureDate: Date())
        let thirdInsert = sut.saveCapturedPokemon(id: 3, captureDate: Date())
        XCTAssertTrue(firstInsert)
        XCTAssertTrue(secondInsert)
        XCTAssertTrue(thirdInsert)
    }
    
    func test_getCapturedPokemon_whenDatabaseIsEmpty_shouldReturnEmptyList() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let result = sut.getCapturedPokemon()
        XCTAssertEqual(result, [])
    }
    
    func test_getCapturedPokemon_whenPokemonsAreSavedInDatabase_shouldReturnListWithElements() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let _ = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        let result = sut.getCapturedPokemon()
        XCTAssertEqual(result.count, 1)
    }
    
    func test_deletePokemon_whenDatabaseIsEmpty_shouldReturnFalse() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let result = sut.deletePokemon(id: 1)
        XCTAssertFalse(result)
    }
    
    func test_deletePokemon_whenPokemonsAreSavedInDatabase_shouldReturnTrue() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let insert = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        let result = sut.deletePokemon(id: 1)
        XCTAssertTrue(insert)
        XCTAssertTrue(result)
    }
    
    func test_getCapturedPokemon_whenPokemonsAreSavedAndDeleted() throws {
        let sut = PokemonDatabaseManager(context: persistanceController.persistentContainer.viewContext)
        let initialDatabase = sut.getCapturedPokemon()
        let _ = sut.saveCapturedPokemon(id: 1, captureDate: Date())
        let databaseAfterInsert = sut.getCapturedPokemon()
        let _ = sut.deletePokemon(id: 1)
        let databaseAfterDelete = sut.getCapturedPokemon()
        XCTAssertEqual(initialDatabase.count, 0)
        XCTAssertEqual(databaseAfterInsert.count, 1)
        XCTAssertEqual(databaseAfterDelete.count, 0)
    }
}
