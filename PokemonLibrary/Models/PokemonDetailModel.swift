//
//  PokemonDetailModel.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

protocol PokemonDetailModelProtocol {
    var name: String { get }
    var image: URL? { get }
    var pokedexNumber: String { get }
    var types: [PokemonTypeModel] { get }
    var weight: String { get }
    var height: String { get }
}

struct PokemonDetailModel: PokemonDetailModelProtocol {

    // MARK: - Computed Properties

    var name: String {
        pokemonData.name.capitalized
    }

    var image: URL? {
        PokemonUtils.generatePosterURL(for: pokemonData.id)
    }

    var pokedexNumber: String {
        String("No.º \(pokemonData.id)")
    }

    var weight: String {
        let double = Double(pokemonData.weight)
        let decimal = NSDecimalNumber(value: double)
        let result = decimal.dividing(by: NSDecimalNumber(value: 10))

        return "\(result)" + " Kg"
    }

    var height: String {
        let double = Double(pokemonData.height)
        let decimal = NSDecimalNumber(value: double)
        let result = decimal.dividing(by: NSDecimalNumber(value: 10))

        return "\(result)" + " m"
    }

    var types: [PokemonTypeModel] {
        pokemonData.types.map { PokemonTypeModel(type: $0) }
    }

    var species: String {
        pokemonData.species.name
    }

    var baseExperience: String {
        "\(pokemonData.baseExperience ?? 0)"
    }

    var moves: String {
        var moves = ""
        for move in pokemonData.moves {
            moves += "\(move.move?.name ?? ""), "
        }
        return moves
    }

    var abilities: String {
        var abilities = ""
        for abilitie in pokemonData.abilities {
            abilities += "\(abilitie.ability.name), "
        }
        return abilities
    }

    // MARK: - Private Properties

    private let pokemonData: PokemonDetailResponse

    // MARK: - Initialization

    init(pokemonData: PokemonDetailResponse) {
        self.pokemonData = pokemonData
    }
}
