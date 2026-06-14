//
//  GetPokemonUseCaseTests.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 28/12/2025.
//

import XCTest
@testable import ConcurrencyPokedex

final class GetPokemonUseCaseTests: XCTestCase {
    var sut = GetPokemonUseCase(dataSource: PokemonDataSourceMock())

    func testGetPokemonWithDefaultId() async throws {
        let expectedId = 0
        let result = try await sut.perform(id: "")
        
        XCTAssertEqual(result.id, expectedId)
    }
    
    func testGetPokemonWithId() async throws {
        let expectedId = 1
        let result = try await sut.perform(id: "\(expectedId)")
        
        XCTAssertEqual(result.id, expectedId)
    }
}
