//
//  DetailsViewModelTests.swift
//  PokemonLibraryTests
//
//  Created by Tiago Antunes on 03/03/2024.
//

import Combine
import Foundation
import XCTest
@testable import PokemonLibrary

class DetailsViewModelTests: XCTestCase {

    func test_showPokemonDetailsOnAppear() {
        let mockPokemonAPIService = MockPokemonAPIService()

        mockPokemonAPIService.stub(for: PokemonDetailRequest.self, response: { _ in
            Result.Publisher(
                PokemonDetailResponse(
                    abilities: [],
                    baseExperience: nil,
                    forms: [],
                    gameIndices: [],
                    height: 0,
                    weight: 0,
                    id: 0,
                    heldItems: [],
                    isDefault: false,
                    locationAreaEncounters: "",
                    moves: [],
                    name: "",
                    order: 0,
                    sprites: .init(
                        backDefault: nil,
                        backShiny: nil,
                        backFemale: nil,
                        backShinyFemale: nil,
                        frontDefault: nil,
                        frontShiny: nil,
                        frontFemale: nil,
                        frontShinyFemale: nil
                    ),
                    species: .init(name: "", url: nil),
                    stats: [],
                    types: []
                )
            ).eraseToAnyPublisher()
        })

        let viewModel = DetailsViewModel(
            pokemon: TestData.pokemonModel,
            apiService: mockPokemonAPIService
        )

        XCTAssertTrue(viewModel.pokemonDetail.name.isEmpty)
    }

    func test_emptyDetailsForEmptyJson() {
        let mockPokemonAPIService = MockPokemonAPIService()

        mockPokemonAPIService.stub(for: PokemonDetailRequest.self, response: { _ in
            Result.Publisher(
                PokemonDetailResponse(
                    abilities: [],
                    baseExperience: nil,
                    forms: [],
                    gameIndices: [],
                    height: 0,
                    weight: 0,
                    id: 0,
                    heldItems: [],
                    isDefault: false,
                    locationAreaEncounters: "",
                    moves: [],
                    name: "",
                    order: 0,
                    sprites: .init(
                        backDefault: nil,
                        backShiny: nil,
                        backFemale: nil,
                        backShinyFemale: nil,
                        frontDefault: nil,
                        frontShiny: nil,
                        frontFemale: nil,
                        frontShinyFemale: nil
                    ),
                    species: .init(name: "", url: nil),
                    stats: [],
                    types: []
                )
            ).eraseToAnyPublisher()
        })

        let viewModel = DetailsViewModel(
            pokemon: TestData.pokemonModel,
            apiService: mockPokemonAPIService
        )

        XCTAssertTrue(!viewModel.pokemonDetail.species.isEmpty)
    }

    func test_throwParseErrorForMalformedJson() {
        let mockPokemonAPIService = MockPokemonAPIService()

        mockPokemonAPIService.stub(for: PokemonDetailRequest.self, response: { _ in
            Result.Publisher(
                APIServiceError.parseError
            ).eraseToAnyPublisher()
        })

        let viewModel = DetailsViewModel(
            pokemon: TestData.pokemonModel,
            apiService: mockPokemonAPIService
        )

        XCTAssertEqual(viewModel.errorMessage, APIServiceError.parseError.errorDescription)
    }
}
