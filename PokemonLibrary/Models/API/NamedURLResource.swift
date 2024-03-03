//
//  NamedURLResource.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

struct NamedURLResource: Decodable, Hashable {
    let name: String
    let url: URL?
}
