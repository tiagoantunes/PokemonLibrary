//
//  GalleryView.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import SwiftUI

struct GalleryView: View {

    enum Constants {
        static let title = "Pokemon List"
        static let galleryIconName = "rectangle.split.3x3"
        static let listIconName = "list.dash"
        static let orderIconName = "textformat"
    }

    @ObservedObject private(set) var viewModel: GalleryViewModel

    private let columns = [
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100)),
        GridItem(.adaptive(minimum: 100))
    ]

    init(viewModel: GalleryViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            galleryModeView
                .navigationBarTitle(Constants.title)
                .navigationBarItems(trailing: galleryModeButton)
                .navigationBarItems(leading: itemOrderButton)
                .onAppear {
                    viewModel.requestInitialSetOfItems()
                }

            if viewModel.dataIsLoading {
                ProgressView()
            }
        }
    }

    private var galleryModeView: some View {
        Group {
            if viewModel.galleryMode == .grid {
                gridView
            } else {
                listView
            }
        }
    }

    private var galleryModeButton: some View {
        Button(action: {
            print("Gallery mode icon pressed...")
            viewModel.changeGalleryViewMode()
        }) {
            Image(systemName: viewModel.galleryMode == .list ? Constants.galleryIconName : Constants.listIconName)
                .imageScale(.large)
        }
    }

    private var itemOrderButton: some View {
        Button(action: {
            print("Item order icon pressed...")
            viewModel.changeSortMode()

        }) {
            Image(systemName: Constants.orderIconName)
                .imageScale(.large)
                .tint(viewModel.isSorted ? .gray : .blue)
        }
    }

    private var listView: some View {
        List(viewModel.pokemonListFormated.indices, id: \.self) { index in
            let pokemon = viewModel.pokemonForIndex(index)
            NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(pokemon: pokemon, apiService: PokemonAPIService()))) {
                ListRowView(pokemon: pokemon)
            }
                .onAppear {
                    viewModel.requestMoreItemsIfNeeded(index: index)
                }
                /*.onTapGesture {
                    viewModel.didSelectItem(index: index)
                }*/
        }
    }

    private var gridView: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.pokemonListFormated.indices, id: \.self) { index in
                    let pokemon = viewModel.pokemonForIndex(index)
                    NavigationLink(destination: DetailsView(viewModel: DetailsViewModel(pokemon: pokemon, apiService: PokemonAPIService()))) {
                        GridElementView(pokemon: pokemon)
                    }
                    .onAppear {
                        viewModel.requestMoreItemsIfNeeded(index: index)
                    }
                    /*.onTapGesture {
                     viewModel.didSelectItem(index: index)
                     }*/
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: Preview

struct GalleryView_Previews: PreviewProvider {
    static var previews: some View {
        GalleryView(
            viewModel: GalleryViewModel(
                pokemonList: [TestData.pokemonModel],
                apiService: PokemonAPIService(),
                output: nil
            )
        )
    }
}
