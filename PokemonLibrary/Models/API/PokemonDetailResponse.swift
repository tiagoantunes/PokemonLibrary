//
//  PokemonDetailResponse.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Foundation

struct PokemonDetailResponse: Decodable {
    let abilities: [PokemonAbility]
    let baseExperience: Int?
    let forms: [NamedURLResource]
    let gameIndices: [VersionGameIndex]
    let height: Int
    let weight: Int
    let id: Int
    let heldItems: [HeldItem]
    let isDefault: Bool
    let locationAreaEncounters: String
    let moves: [PokemonMove]
    let name: String
    let order: Int
    let sprites: Sprite?
    let species: NamedURLResource
    let stats: [PokemonStat]
    let types: [PokemonType]
}

// MARK: - Pokemon empty initialization
extension PokemonDetailResponse {

    static let empty = PokemonDetailResponse(
        abilities: [],
        baseExperience: nil,
        forms: [],
        gameIndices: [],
        height: 0,
        weight: 0,
        id: 0,
        heldItems: [],
        isDefault: false,
        locationAreaEncounters: "",
        moves: [],
        name: "",
        order: 0,
        sprites: .init(
            backDefault: nil,
            backShiny: nil,
            backFemale: nil,
            backShinyFemale: nil,
            frontDefault: nil,
            frontShiny: nil,
            frontFemale: nil,
            frontShinyFemale: nil
        ),
        species: .init(name: "", url: nil),
        stats: [],
        types: []
    )
}

// MARK: - PokemonAbility
extension PokemonDetailResponse {

    struct PokemonAbility: Decodable {
        let ability: NamedURLResource
        let isHidden: Bool
        let slot: Int
    }
}

// MARK: - HeldItem
extension PokemonDetailResponse {

    struct HeldItem: Decodable {
        let item: NamedURLResource
        let versionDetails: [VersionDetail]
    }
}

// MARK: - VersionDetail
extension PokemonDetailResponse.HeldItem {

    struct VersionDetail: Decodable {
        let rarity: Int
        let version: NamedURLResource
    }
}

// MARK: - PokemonMove
extension PokemonDetailResponse {

    struct PokemonMove: Decodable {
        let move: NamedURLResource?
        let versionGroupDetails: [VersionGroupDetail]
    }
}

// MARK: - VersionGroupDetail
extension PokemonDetailResponse.PokemonMove {

    struct VersionGroupDetail: Decodable {
        let levelLearnedAt: Int
        let moveLearnMethod: NamedURLResource
        let versionGroup: NamedURLResource
    }
}

// MARK: - Sprite
extension PokemonDetailResponse {

    struct Sprite: Decodable {
        let backDefault: URL?
        let backShiny: URL?
        let backFemale: URL?
        let backShinyFemale: URL?
        let frontDefault: URL?
        let frontShiny: URL?
        let frontFemale: URL?
        let frontShinyFemale: URL?
    }
}

// MARK: - PokemonStat
extension PokemonDetailResponse {

    struct PokemonStat: Decodable {
        let stat: NamedURLResource
        let baseStat: Int
        let effort: Int
    }
}

// MARK: - PokemonType
extension PokemonDetailResponse {

    struct PokemonType: Decodable {
        let slot: Int
        let type: NamedURLResource
    }
}
// MARK: - VersionGameIndex
extension PokemonDetailResponse {

    struct VersionGameIndex: Decodable {
        let gameIndex: Int
        let version: NamedURLResource
    }
}
