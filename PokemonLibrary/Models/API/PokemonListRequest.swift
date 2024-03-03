//
//  PokemonListRequest.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

struct PokemonListRequest: APIRequestType {
    typealias ModelType = PokemonListResponse

    let offset: Int
    let limit: Int

    var baseURL: String {
        Environment.pokemonServerURL
    }

    var version: String {
        "v2"
    }

    var path: String? {
        "/pokemon"
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]? {
        [
            URLQueryItem(name: "limit", value: String(limit)),
            URLQueryItem(name: "offset", value: String(offset))
        ]
    }
}
