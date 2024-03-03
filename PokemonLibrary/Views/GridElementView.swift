//
//  GridElementView.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Kingfisher
import SwiftUI
import UIKit

struct GridElementView: View {
    let pokemon: PokemonModel
    @State private var isAnimating = true

    var body: some View {
        ZStack {
            KFImage(pokemon.image)
                .fade(duration: 0.35)
                .onSuccess { _ in
                    isAnimating = false
                }
                .resizable()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                .clipped()
                .aspectRatio(1, contentMode: .fit)
            VStack {
                Spacer()
                ZStack {
                    Text(pokemon.name)
                        .font(.subheadline)
                        .lineLimit(1)
                }
                .frame(maxWidth: .infinity)
                .background(.thinMaterial)
            }
        }
    }
}

struct GridElementView_Previews: PreviewProvider {
    static var previews: some View {
        GridElementView(
            pokemon: TestData.pokemonModel
        )
    }
}
