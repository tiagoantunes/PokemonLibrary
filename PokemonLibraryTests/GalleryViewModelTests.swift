//
//  GalleryViewModelTests.swift
//  PokemonLibraryTests
//
//  Created by Tiago Antunes on 03/03/2024.
//

import Combine
import Foundation
import XCTest
@testable import PokemonLibrary

class GalleryViewModelTests: XCTestCase {

    func test_updateGalleryViewListOnAppear() {
        let mockPokemonAPIService = MockPokemonAPIService()

        mockPokemonAPIService.stub(for: PokemonListRequest.self, response: { _ in
            Result.Publisher(
                PokemonListResponse(
                    count: 1,
                    next: URL(string: "https://pokeapi.co/api/v2/pokemon?offset=10&limit=10"),
                    previous: nil,
                    results: [
                        NamedURLResource(
                            name: "bulbasaur",
                            url: URL(string: "https://pokeapi.co/api/v2/pokemon/1/")
                        )
                    ]
                )
            ).eraseToAnyPublisher()
        })

        let viewModel = GalleryViewModel(apiService: mockPokemonAPIService, output: nil)

        XCTAssertTrue(viewModel.pokemonList.isEmpty)
    }

    func test_emptyGalleryListForEmptyJson() {
        let mockPokemonAPIService = MockPokemonAPIService()

        mockPokemonAPIService.stub(for: PokemonListRequest.self, response: { _ in
            Result.Publisher(
                PokemonListResponse(
                    count: 1,
                    next: URL(string: "https://pokeapi.co/api/v2/pokemon?offset=10&limit=10"),
                    previous: nil,
                    results: []
                )
            ).eraseToAnyPublisher()
        })

        let viewModel = GalleryViewModel(apiService: mockPokemonAPIService, output: nil)

        XCTAssertTrue(!viewModel.pokemonList.isEmpty)
    }

    func test_throwParseErrorForMalformedJson() {
        let mockPokemonAPIService = MockPokemonAPIService()

        mockPokemonAPIService.stub(for: PokemonListRequest.self, response: { _ in
            Result.Publisher(
                APIServiceError.parseError
            ).eraseToAnyPublisher()
        })

        let viewModel = GalleryViewModel(apiService: mockPokemonAPIService, output: nil)

        XCTAssertEqual(viewModel.errorMessage, APIServiceError.parseError.errorDescription)
    }
}
