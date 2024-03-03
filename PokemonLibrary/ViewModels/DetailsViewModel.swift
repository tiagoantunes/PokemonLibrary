//
//  DetailsViewModel.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Combine
import Foundation
import SwiftUI

final class DetailsViewModel: ObservableObject {
    let pokemon: PokemonModel
    private var cancellable: Set<AnyCancellable>
    private let apiService: APIServiceType

    @Published var dataIsLoading = false
    @Published var pokemonDetail = PokemonDetailModel(pokemonData: .empty)
    @Published var isErrorShown = false
    @Published var errorMessage = ""

    init(
        pokemon: PokemonModel,
        apiService: APIServiceType
    ) {
        self.pokemon = pokemon
        self.apiService = apiService
        self.cancellable = Set<AnyCancellable>()
    }

    func requestItemDetail() {
        dataIsLoading = true
        self.apiService.call(from: PokemonDetailRequest(id: pokemon.id))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                if case let .failure(error) = result {
                    self?.errorMessage = error.localizedDescription
                    self?.isErrorShown = true
                    self?.dataIsLoading = false
                }
            }, receiveValue: { [weak self] response in
                self?.pokemonDetail = PokemonDetailModel(pokemonData: response)
                
                self?.dataIsLoading = false
            })
            .store(in: &cancellable)
    }
}
