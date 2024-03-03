//
//  PokemonTypeModel.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation
import SwiftUI

protocol PokemonTypeModelProtocol: Identifiable {
    var id: Int { get }
    var name: String { get }
    var url: URL? { get }
    var color: [Color] { get }
    var nameColor: Color { get }
}

struct PokemonTypeModel: PokemonTypeModelProtocol {

    // MARK: - Computed Properties

    var id: Int {
        Int(type.type.url?.absoluteString.split(separator: "/").last ?? "0") ?? 0
    }

    var name: String {
        pokemonType.localized
    }

    var url: URL? {
        type.type.url
    }

    var color: [Color] {
        pokemonType.color
    }

    var nameColor: Color {
        pokemonType.textColor
    }

    // MARK: - Private Properties

    private var pokemonType: PokemonType {
        PokemonType(rawValue: type.type.name) ?? .normal
    }

    private let type: PokemonDetailResponse.PokemonType

    // MARK: - Initialization

    init(type: PokemonDetailResponse.PokemonType) {
        self.type = type
    }
}
