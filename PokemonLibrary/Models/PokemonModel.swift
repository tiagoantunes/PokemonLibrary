//
//  PokemonModel.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

protocol PokemonModelProtocol {
    var id: Int { get }
    var image: URL? { get }
    var name: String { get }
}

struct PokemonModel: PokemonModelProtocol {

    var id: Int {
        PokemonUtils.generate(from: pokemonData.url?.absoluteString ?? "" )
    }

    var image: URL? {
        PokemonUtils.generatePosterURL(for: id)
    }

    var name: String {
        pokemonData.name.capitalized
    }

    // MARK: - Private Properties

    private let pokemonData: NamedURLResource

    // MARK: - Initialization

    init(_ pokemonData: NamedURLResource) {
        self.pokemonData = pokemonData
    }
}

extension PokemonModel: Equatable {

    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}
