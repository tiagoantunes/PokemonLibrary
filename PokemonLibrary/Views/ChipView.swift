//
//  ChipView.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 03/03/2024.
//

import SwiftUI

struct ChipView: View {

    let titleKey: String
    let textColor: Color
    let colors: [Color]

    var body: some View {
        Text(titleKey)
            .foregroundColor(textColor)
            .font(.body)
            .lineLimit(1)
            .padding(.vertical, 4)
            .padding(.horizontal, 20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(gradient: Gradient(colors: colors),
                                         startPoint: .top,
                                         endPoint: .bottom))
            )
    }
}

#Preview {
    ChipView(
        titleKey: "Title",
        textColor: .white,
        colors: [Color.dragonType1, Color.dragonType2])
}
