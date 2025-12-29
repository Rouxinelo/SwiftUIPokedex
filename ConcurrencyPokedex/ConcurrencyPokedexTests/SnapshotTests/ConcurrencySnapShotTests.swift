//
//  ConcurrencySnapShotTests.swift
//  ConcurrencyPokedexTests
//
//  Created by João Rouxinol on 27/12/2025.
//

import SnapshotTesting
import XCTest
@testable import ConcurrencyPokedex

final class ConcurrencySnapShotTests: XCTestCase {
    var recordMode = false
    
    @MainActor func testPokedexView() throws {
        let view = PokedexView(viewModel: PokedexViewModel(getPokemonListUseCase: GetPokemonListUseCaseMock(), getPokemonUseCase: GetPokemonUseCaseMock()))
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    @MainActor func testPokemonDetailView() throws {
        let view = PokemonDetailView(pokemon: PokemonRepresentableMock(), isFavorite: false)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    func testPokedexPokemonView() throws {
        let view = PokedexPokemonView(pokemon: PokemonRepresentableMock(), onClick: {})
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    func testFullScreenLoadingView() throws {
        let view = FullScreenLoadingView()
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    func testTableLoadingView() throws {
        let view = TableLoadingView()
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    func testNavigationBar() throws {
        let view = NavigationBar(title: "Example Title")
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    func testStatBar() throws {
        let view = StatBar(statName: "TEST", statColor: .red, statValue: 100, statMax: 200)
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
    
    func testImageButton() throws {
        let view = ImageButton(imageName: "pokeball", text: "Example Button", backgroundColor: .red, onClick: {})
        assertSnapshot(of: view, as: .image(layout: .device(config: .iPhone13)), record: recordMode)
    }
}
