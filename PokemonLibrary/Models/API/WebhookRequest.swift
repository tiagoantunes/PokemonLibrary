//
//  WebhookRequest.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 04/03/2024.
//

import Foundation

struct WebhookRequest: APIRequestType {
    typealias ModelType = Data

    let pokemon: PokemonModel

    var baseURL: String {
        Environment.webhookUrl
    }

    var version: String {
        ""
    }

    var path: String? {
        ""
    }

    var method: HTTPMethod {
        .post
    }

    var queryItems: [URLQueryItem]?

    var body: Data? {
        do {
            return try JSONSerialization.data(
                withJSONObject:
                    ["name": pokemon.name,
                     "id": pokemon.id]
            )
        } catch {
            return nil
        }
    }
}
