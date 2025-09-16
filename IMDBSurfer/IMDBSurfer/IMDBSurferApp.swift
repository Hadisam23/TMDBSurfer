//
//  IMDBSurferApp.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

import SwiftUI

@main
struct IMDBSurferApp: App {
    @StateObject private var themeManager = ThemeManager.shared
    
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
