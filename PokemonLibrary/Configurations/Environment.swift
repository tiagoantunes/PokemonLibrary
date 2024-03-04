//
//  Environment.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

public enum Environment {
    enum Keys {
        static let pokemonServerUrl = "POKEAPI_SERVER_URL"
        static let pokemonApiKey = "POKEAPI_KEY"
        static let webhookUrl = "WEBHOOK_URL"
    }

    private static let infoDictionary: [String: Any] = {
        guard let dictionary = Bundle.main.infoDictionary else {
            fatalError("plist not exist")
        }
        return dictionary
    }()

    // MARK: - Plist values
    static let pokemonServerURL: String = {
        guard let serverURLstring = infoDictionary[Keys.pokemonServerUrl] as? String else {
            fatalError("Server url dont exist for this environment")
        }
        return serverURLstring
    }()

    static let pokemonApiKey: String = {
        guard let apiKey = infoDictionary[Keys.pokemonApiKey] as? String else {
            fatalError("Api key dont exist for this environment")
        }
        return apiKey
    }()

    static let webhookUrl: String = {
        guard let webhookUrl = infoDictionary[Keys.webhookUrl] as? String else {
            fatalError("webhookUrl dont exist for this environment")
        }
        return webhookUrl
    }()
}
