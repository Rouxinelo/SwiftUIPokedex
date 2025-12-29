//
//  GetPokemonListUseCaseTests.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 28/12/2025.
//

import XCTest
@testable import ConcurrencyPokedex

final class GetPokemonListUseCaseTests: XCTestCase {
    var sut = GetPokemonListUseCase(dataSource: PokemonDataSourceMock())

    func test_performUseCase_whenLimitIsZero_checkCountIsEqualToLimit_passes() async throws {
        let limit = 0
        let result = try await sut.perform(limit: limit, offset: 0)
        
        XCTAssertEqual(result.count, limit)
    }
    
    func test_performUseCase_whenLimitIsTen_checkResultSizeIsEqualToLimit_passes() async throws {
        let limit = 10
        let result = try await sut.perform(limit: limit, offset: 10)
        
        XCTAssertEqual(result.results.count, limit)
    }
    
    func test_performUseCase_whenLimitIsZero_checkResultSizeIsEqualToLimit_passes() async throws {
        let limit = 0
        let result = try await sut.perform(limit: limit, offset: 10)
        
        XCTAssertEqual(result.results.count, limit)
    }
}
