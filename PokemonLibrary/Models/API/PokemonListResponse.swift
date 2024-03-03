//
//  PokemonListResponse.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [NamedURLResource]
}
