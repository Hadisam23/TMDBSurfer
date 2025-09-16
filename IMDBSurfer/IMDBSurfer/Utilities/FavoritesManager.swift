//
//  FavoritesManager.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation
import SwiftUI

class FavoritesManager: ObservableObject {
    static let shared = FavoritesManager()
    
    @Published var favoriteMovies: [Movie] = []
    @Published var favoriteTVShows: [TVShow] = []
    @Published var favoriteSearchResults: [SearchResult] = []
    
    private let userDefaults = UserDefaults.standard
    private let moviesKey = "favoriteMovies"
    private let tvShowsKey = "favoriteTVShows"
    private let searchResultsKey = "favoriteSearchResults"
    
    private init() {
        loadFavorites()
    }
    
    // MARK: - Movies
    func addMovie(_ movie: Movie) {
        if !favoriteMovies.contains(where: { $0.id == movie.id }) {
            favoriteMovies.append(movie)
            saveMovies()
        }
    }
    
    func removeMovie(_ movie: Movie) {
        favoriteMovies.removeAll { $0.id == movie.id }
        saveMovies()
    }
    
    func isMovieFavorite(_ movie: Movie) -> Bool {
        return favoriteMovies.contains { $0.id == movie.id }
    }
    
    // MARK: - TV Shows
    func addTVShow(_ tvShow: TVShow) {
        if !favoriteTVShows.contains(where: { $0.id == tvShow.id }) {
            favoriteTVShows.append(tvShow)
            saveTVShows()
        }
    }
    
    func removeTVShow(_ tvShow: TVShow) {
        favoriteTVShows.removeAll { $0.id == tvShow.id }
        saveTVShows()
    }
    
    func isTVShowFavorite(_ tvShow: TVShow) -> Bool {
        return favoriteTVShows.contains { $0.id == tvShow.id }
    }
    
    // MARK: - Search Results
    func addSearchResult(_ result: SearchResult) {
        if !favoriteSearchResults.contains(where: { $0.id == result.id }) {
            favoriteSearchResults.append(result)
            saveSearchResults()
        }
    }
    
    func removeSearchResult(_ result: SearchResult) {
        favoriteSearchResults.removeAll { $0.id == result.id }
        saveSearchResults()
    }
    
    func isSearchResultFavorite(_ result: SearchResult) -> Bool {
        return favoriteSearchResults.contains { $0.id == result.id }
    }
    
    // MARK: - Generic Content Item
    func addContent<T: ContentItem>(_ content: T) {
        if let movie = content as? Movie {
            addMovie(movie)
        } else if let tvShow = content as? TVShow {
            addTVShow(tvShow)
        } else if let searchResult = content as? SearchResult {
            addSearchResult(searchResult)
        }
    }
    
    func removeContent<T: ContentItem>(_ content: T) {
        if let movie = content as? Movie {
            removeMovie(movie)
        } else if let tvShow = content as? TVShow {
            removeTVShow(tvShow)
        } else if let searchResult = content as? SearchResult {
            removeSearchResult(searchResult)
        }
    }
    
    func isContentFavorite<T: ContentItem>(_ content: T) -> Bool {
        if let movie = content as? Movie {
            return isMovieFavorite(movie)
        } else if let tvShow = content as? TVShow {
            return isTVShowFavorite(tvShow)
        } else if let searchResult = content as? SearchResult {
            return isSearchResultFavorite(searchResult)
        }
        return false
    }
    
    // MARK: - All Favorites
    var allFavorites: [any ContentItem] {
        var all: [any ContentItem] = []
        all.append(contentsOf: favoriteMovies)
        all.append(contentsOf: favoriteTVShows)
        all.append(contentsOf: favoriteSearchResults)
        return all
    }
    
    // MARK: - Persistence
    private func loadFavorites() {
        loadMovies()
        loadTVShows()
        loadSearchResults()
    }
    
    private func loadMovies() {
        if let data = userDefaults.data(forKey: moviesKey),
           let movies = try? JSONDecoder().decode([Movie].self, from: data) {
            favoriteMovies = movies
        }
    }
    
    private func loadTVShows() {
        if let data = userDefaults.data(forKey: tvShowsKey),
           let tvShows = try? JSONDecoder().decode([TVShow].self, from: data) {
            favoriteTVShows = tvShows
        }
    }
    
    private func loadSearchResults() {
        if let data = userDefaults.data(forKey: searchResultsKey),
           let results = try? JSONDecoder().decode([SearchResult].self, from: data) {
            favoriteSearchResults = results
        }
    }
    
    private func saveMovies() {
        if let data = try? JSONEncoder().encode(favoriteMovies) {
            userDefaults.set(data, forKey: moviesKey)
        }
    }
    
    private func saveTVShows() {
        if let data = try? JSONEncoder().encode(favoriteTVShows) {
            userDefaults.set(data, forKey: tvShowsKey)
        }
    }
    
    private func saveSearchResults() {
        if let data = try? JSONEncoder().encode(favoriteSearchResults) {
            userDefaults.set(data, forKey: searchResultsKey)
        }
    }
}
