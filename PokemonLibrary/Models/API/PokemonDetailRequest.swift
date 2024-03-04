//
//  PokemonDetailRequest.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

struct PokemonDetailRequest: APIRequestType {
    typealias ModelType = PokemonDetailResponse

    let id: Int

    var baseURL: String {
        Environment.pokemonServerURL
    }

    var version: String {
        "v2"
    }

    var path: String? {
        "/pokemon/\(id)"
    }

    var method: HTTPMethod {
        .get
    }

    var queryItems: [URLQueryItem]?
}
