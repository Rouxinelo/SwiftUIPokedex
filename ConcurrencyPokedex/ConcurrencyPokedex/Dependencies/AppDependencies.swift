//
//  AppDependencies.swift
//  ConcurrencyPokedex
//
//  Created by João Rouxinol on 07/12/2025.
//

import Foundation

protocol AppDependenciesProtocol {
    var getPokemonListUseCase: GetPokemonListUseCaseProtocol { get }
    var getPokemonUseCase: GetPokemonUseCaseProtocol { get }
}

class AppDependencies: AppDependenciesProtocol {
    var dataSource: PokemonDataSourceProtocol
    var getPokemonListUseCase: GetPokemonListUseCaseProtocol
    var getPokemonUseCase: GetPokemonUseCaseProtocol
    
    init(networkProvider: NetworkProviderProtocol) {
        dataSource = PokemonDataSource(network: networkProvider)
        getPokemonListUseCase = GetPokemonListUseCase(dataSource: dataSource)
        getPokemonUseCase = GetPokemonUseCase(dataSource: dataSource)
    }
}
