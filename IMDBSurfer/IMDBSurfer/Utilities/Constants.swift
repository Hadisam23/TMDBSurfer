//
//  Constants.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

struct Constants {
    static var tmdbAPIKey: String {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil),
              let content = try? String(contentsOfFile: path, encoding: .ascii) else {
            fatalError("Could not load .env file")
        }
        
        let lines = content.components(separatedBy: .newlines)
        for line in lines {
            let components = line.components(separatedBy: "=")
            if components.count == 2 && components[0].trimmingCharacters(in: .whitespaces) == "TMDB_API_KEY" {
                return components[1].trimmingCharacters(in: .whitespaces)
            }
        }
        
        fatalError("TMDB_API_KEY not found in .env file")
    }
    
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"
}
