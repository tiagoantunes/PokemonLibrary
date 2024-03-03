//
//  ListRowView.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import Kingfisher
import SwiftUI
import UIKit

struct ListRowView: View {
    let pokemon: PokemonModel
    @State private var isAnimating = true

    init(
        pokemon: PokemonModel,
        isAnimating: Bool = true
    ) {
        self.pokemon = pokemon
        self.isAnimating = isAnimating
    }

    var body: some View {
        HStack(spacing: 24.0) {
            KFImage(pokemon.image)
                .fade(duration: 0.35)
                .onSuccess { _ in
                    isAnimating = false
                }
                .resizable()
                .frame(width: 70.0, height: 70.0)
                .aspectRatio(contentMode: .fill)
                .clipped()
            VStack(alignment: .leading, spacing: 4.0) {
                Text(pokemon.name)
                    .font(.headline)
                Text("No.º")
                        .font(.subheadline)
                Text(String(pokemon.id))
                        .font(.caption)
                        .foregroundColor(.secondary)
            }
            Spacer()
        }
    }

}

struct CharacterRow_Previews: PreviewProvider {
    static var previews: some View {
        ListRowView(
            pokemon: TestData.pokemonModel
        )
        .previewLayout(.fixed(width: 200, height: 200))
    }
}
