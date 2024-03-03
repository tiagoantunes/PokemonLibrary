//
//  PokemonLibraryApp.swift
//  PokemonLibrary
//
//  Created by Tiago Antunes on 02/03/2024.
//

import SwiftUI

@main
struct PokemonBreedsApp: App {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                appCoordinator.view(page: .gallery)
                    .navigationDestination(
                        for: Page.self
                    ) { destination in
                        appCoordinator.view(page: destination)
                    }
            }
            .environmentObject(appCoordinator)
        }
    }
}
