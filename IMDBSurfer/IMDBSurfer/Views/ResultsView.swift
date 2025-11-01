//
//  SearchResultsView.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

// SearchResultsView.swift
import SwiftUI
import Kingfisher

struct SearchResultsView: View {
    let searchResults: [SearchResult]
    let isSearching: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            if isSearching {
                HStack {
                    Spacer()
                    ProgressView("Searching...")
                    Spacer()
                }
                .padding()
            } else if searchResults.isEmpty {
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.gray)
                    Text("No results found")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
            } else {
                ScrollView {
                    LazyVGrid(columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ], spacing: 16) {
                        ForEach(searchResults) { result in
                            SearchResultCard(result: result)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct SearchResultCard: View {
    let result: SearchResult
    @StateObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationLink(destination: destinationView) {
        VStack(alignment: .leading, spacing: 8) {
            // Poster with Favorite Button
            ZStack(alignment: .topTrailing) {
                KFImage(result.fullPosterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(12)
                .clipped()
                
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: favoritesManager.isSearchResultFavorite(result) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesManager.isSearchResultFavorite(result) ? .red : .white)
                        .font(.title2)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(result.title ?? result.name ?? "")
                    .font(.headline)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                
                HStack {
                    Text(result.mediaType?.capitalized ?? "")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 2)
                        .background(result.isMovie ? Color.blue : Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                    
                    Spacer()
                    
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", result.voteAverage ?? 0.0))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        }
    }
    
    @ViewBuilder
    private var destinationView: some View {
        if result.isMovie {
            // Convert SearchResult to Movie for details view
            let movie = Movie(
                id: result.id,
                title: result.title,
                overview: result.overview,
                posterPath: result.posterPath,
                releaseDate: result.releaseDate,
                voteAverage: result.voteAverage,
                name: nil
            )
            MovieDetailsView(movie: movie)
        } else {
            // Convert SearchResult to TVShow for details view
            let tvShow = TVShow(
                id: result.id,
                title: result.title,
                overview: result.overview,
                posterPath: result.posterPath,
                firstAirDate: result.releaseDate,
                voteAverage: result.voteAverage,
                releaseDate: nil,
                name: result.name
            )
            TVShowDetailsView(tvShow: tvShow)
        }
    }
    
    private func toggleFavorite() {
        if favoritesManager.isSearchResultFavorite(result) {
            favoritesManager.removeSearchResult(result)
        } else {
            favoritesManager.addSearchResult(result)
        }
    }
}
