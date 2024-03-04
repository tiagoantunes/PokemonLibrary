//
//  GalleryViewModel.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Combine
import Foundation
import SwiftUI

enum GalleryViewMode {
    case list
    case grid
}

final class GalleryViewModel: ObservableObject {

    enum Constants {
        static let itemsFromEndThreshold = 10
        static let numberOfItemsInRequest = 20
    }

    struct Output {
        var didSelectItem: (_ pokemon: PokemonModel) -> Void
    }

    private var output: Output?
    private var cancellable: Set<AnyCancellable>
    private let apiService: APIServiceType

    @Published var galleryMode = GalleryViewMode.list
    @Published var isSorted = false
    @Published var pokemonList: [PokemonModel] = []
    @Published var dataIsLoading = false
    @Published var isErrorShown = false
    @Published var errorMessage = ""

    private var itemsLoadedCount: Int?
    private var page = 0
    private let itemsFromEndThreshold = Constants.itemsFromEndThreshold

    init(
         pokemonList: [PokemonModel] = [],
         apiService: APIServiceType,
         output: Output?
    ) {
        self.pokemonList = pokemonList
        self.cancellable = Set<AnyCancellable>()
        self.apiService = apiService
        self.output = output
    }

    var pokemonListFormated: [PokemonModel] {
        if isSorted {
            return pokemonList.sorted { $0.name < $1.name }
        } else {
            return pokemonList
        }
    }

    func pokemonForIndex(_ index: Int) -> PokemonModel {
        pokemonListFormated[index]
    }

    func changeGalleryViewMode() {
        galleryMode = galleryMode == .list ? .grid : .list
    }

    func changeSortMode() {
        isSorted.toggle()
    }

    func didSelectItem(index: Int) {
        output?.didSelectItem(pokemonForIndex(index))
    }
}

// MARK: infinite scrolling logic

extension GalleryViewModel {
    func requestInitialSetOfItems() {
        guard pokemonList.isEmpty else {
            return
        }

        page = 0
        requestItems(page: page)
    }

    func requestMoreItemsIfNeeded(index: Int) {
        guard let itemsLoadedCount = itemsLoadedCount else {
            return
        }

        if thresholdMeet(itemsLoadedCount, index) {
            // Request next page
            page += 1
            requestItems(page: page)
        }
    }

    private func requestItems(page: Int) {
        dataIsLoading = true
        self.apiService.call(from: PokemonListRequest(offset: page, limit: Constants.numberOfItemsInRequest))
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] result in
                if case let .failure(error) = result {
                    self?.errorMessage = error.localizedDescription
                    self?.isErrorShown = true
                    self?.dataIsLoading = false
                }
            }, receiveValue: { [weak self] response in
                let pokemons = response.results.map { PokemonModel($0) }

                self?.page += pokemons.count - 1
                self?.pokemonList.append(contentsOf: pokemons)
                self?.itemsLoadedCount = self?.pokemonList.count
                self?.dataIsLoading = false
            })
            .store(in: &cancellable)
    }

    private func thresholdMeet(_ itemsLoadedCount: Int, _ index: Int) -> Bool {
        return (itemsLoadedCount - index) == itemsFromEndThreshold
    }
}
