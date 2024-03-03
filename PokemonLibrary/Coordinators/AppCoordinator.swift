//
//  AppCoordinator.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import SwiftUI

enum Page {
    case gallery
    case details
}

final class AppCoordinator: ObservableObject {
    @Published var path = NavigationPath()

    func gotoHomePage() {
        path.removeLast(path.count)
    }

    func goToDetails(pokemon: PokemonModel) {
        path.append(Page.details)
    }

    func goBack() {
        path.removeLast()
    }

    // MARK: View Creation Methods

    @ViewBuilder
    func view(page: Page) -> some View {
        switch page {
        case .gallery:
            galleryView()
        case .details:
            detailsView()
        }
    }

    func galleryView() -> some View {
        let viewModel = GalleryViewModel(
            pokemonList: [],
            apiService: PokemonAPIService(),
            output: .init(didSelectItem: { pokemon in
                self.goToDetails(pokemon: pokemon)
            })
        )
        let galleryView = GalleryView(viewModel: viewModel)
        return galleryView
    }

    func detailsView() -> some View {
        /*guard let pokemon = pokemon else {
            fatalError("pokemon details must be provided for details type!")
        }*/
        let viewModel = DetailsViewModel(
            pokemon: TestData.pokemonModel,
            apiService: PokemonAPIService()
        )
        let detailsView = DetailsView(viewModel: viewModel)
        return detailsView
    }
}
