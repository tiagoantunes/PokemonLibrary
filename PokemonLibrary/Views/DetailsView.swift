//
//  DetailsView.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Kingfisher
import SwiftUI

struct DetailsView: View {

    enum Constants {
        static let weight = "Weight"
        static let height = "Height"
        static let baseExperience = "Base Experience"
        static let species = "Species"
        static let moves = "Moves"
        static let abilities = "Abilities"
    }

    @ObservedObject private(set) var viewModel: DetailsViewModel
    @State private var isAnimating = true

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ZStack {
            pokemonDetails
                .navigationBarTitle(viewModel.pokemon.name)
                .onAppear {
                    viewModel.requestItemDetail()
                }

            if viewModel.dataIsLoading {
                ProgressView()
            }
        }
    }

    private var pokemonDetails: some View {
        ScrollView {
            VStack(spacing: 36.0) {
                HStack(alignment: .top, spacing: 24.0) {
                    KFImage(viewModel.pokemon.image)
                        .fade(duration: 0.35)
                        .onSuccess { _ in
                            isAnimating = false
                        }
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: 350)
                        .clipped()
                }
                PokemonDetails(viewModel: viewModel)

                Spacer()
            }
            .padding(.top, 18)
            .padding(.horizontal, 20)
        }
    }
}

// MARK: - BottomInfo
struct PokemonDetails: View {
    @StateObject var viewModel: DetailsViewModel

    var body: some View {
        VStack {
            Text(viewModel.pokemonDetail.name)
                .font(.largeTitle)
            Text(viewModel.pokemonDetail.pokedexNumber)
                .foregroundStyle(Color.gray)
                .font(.largeTitle)
        }

        PokemonTypeView(viewModel: viewModel)

        detailRow(
            title: DetailsView.Constants.abilities,
            content: viewModel.pokemonDetail.abilities
        )

        detailRow(
            title: DetailsView.Constants.species,
            content: viewModel.pokemonDetail.species
        )

        detailRow(
            title: DetailsView.Constants.baseExperience,
            content: viewModel.pokemonDetail.baseExperience
        )

        detailRow(
            title: DetailsView.Constants.height,
            content: viewModel.pokemonDetail.height
        )

        detailRow(
            title: DetailsView.Constants.weight,
            content: viewModel.pokemonDetail.weight
        )

        detailRow(
            title: DetailsView.Constants.moves,
            content: viewModel.pokemonDetail.moves
        )
    }

    private func detailRow(title: String, content: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            Text(content)
                .font(.headline)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private struct PokemonTypeView: View {
    @StateObject var viewModel: DetailsViewModel

    var body: some View {
        Group {
            HStack {
                Spacer()
                ForEach(viewModel.pokemonDetail.types, id: \.id) { element in
                    ChipView(titleKey: element.name, textColor: element.nameColor, colors: element.color)
                }
                Spacer()
            }
            .padding(.bottom, 20)
        }
    }
}

// MARK: - Previews
struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DetailsView(
                viewModel: DetailsViewModel(
                    pokemon: TestData.pokemonModel,
                    apiService: PokemonAPIService()
                )
            )
        }
    }
}
