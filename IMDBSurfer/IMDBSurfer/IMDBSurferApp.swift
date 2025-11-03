//
//  TMDBSurferApp.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

import SwiftUI

@main
struct TMDBSurferApp: App {
    @ObservedObject private var themeManager = ThemeManager.shared
    
    init() {
        // Configure Kingfisher for optimal performance
        ImageConfiguration.setup()
    }
    
    var body: some Scene {
        WindowGroup {
            MoviesView()
                .preferredColorScheme(themeManager.colorScheme)
        }
    }
}
