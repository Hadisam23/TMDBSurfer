//
//  ThemeManager.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import SwiftUI

class ThemeManager: ObservableObject {
    static let shared = ThemeManager()
    
    @Published var isDarkMode: Bool {
        didSet {
            UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
        }
    }
    
    private init() {
        self.isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    }
    
    func toggleTheme() {
        isDarkMode.toggle()
    }
    
    var colorScheme: ColorScheme {
        return isDarkMode ? .dark : .light
    }
}
