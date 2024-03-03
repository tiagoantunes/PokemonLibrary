//
//  TestData.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

enum TestData {
    static var pokemonListResponse: PokemonListResponse? {
        do {
            guard let url = Bundle.main.url(forResource: "pokemon_list", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(PokemonListResponse.self, from: data)
        } catch {
            return nil
        }
    }

    static var pokemonDetailResponse: PokemonDetailResponse? {
        do {
            guard let url = Bundle.main.url(forResource: "pokemon_detail", withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            return try decoder.decode(PokemonDetailResponse.self, from: data)
        } catch {
            return nil
        }
    }

    static var pokemonModel: PokemonModel {
        return PokemonModel(pokemonListResponse!.results.first!)
    }

    static var pokemonDetailModel: PokemonDetailModel {
        return PokemonDetailModel(pokemonData: pokemonDetailResponse!)
    }
}
