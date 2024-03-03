//
//  Environment.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

public enum Environment {
    enum Keys {
        enum Plist {
            static let pokemonServerUrl = "POKEAPI_SERVER_URL"
            static let pokemonApiKey = "POKEAPI_KEY"
        }
    }

    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("plist not exist")
        }
        return dictionary
    }()

    // MARK: - Plist values

    static let pokemonServerURL: String = {
        guard let serverURLstring = infoDictionary[Keys.Plist.pokemonServerUrl] as? String else {
            fatalError("Server url dont exist for this environment")
        }
        return serverURLstring
    }()

    static let pokemonApiKey: String = {
        guard let apiKey = infoDictionary[Keys.Plist.pokemonApiKey] as? String else {
            fatalError("Api key dont exist for this environment")
        }
        return apiKey
    }()
}
