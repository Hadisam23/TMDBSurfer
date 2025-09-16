//
//  MovieDetailsView.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import SwiftUI
import Kingfisher

struct MovieDetailsView: View {
    let movie: Movie
    @StateObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Backdrop Image
                KFImage(movie.fullBackdropURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                
                // Title
                Text(movie.title ?? "Unknown Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Rating and Date
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                    }
                    
                    Spacer()
                    
                    Text(movie.formattedReleaseDate)
                }
                .padding(.horizontal)
                
                // Action Buttons
                HStack(spacing: 12) {
                    Button(favoritesManager.isContentFavorite(movie) ? "Remove" : "Add to Favorites") {
                        toggleFavorite()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Share") {
                        shareMovie()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                
                // Overview
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(movie.overview ?? "No overview available")
                        .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleFavorite() {
        if favoritesManager.isContentFavorite(movie) {
            favoritesManager.removeContent(movie)
        } else {
            favoritesManager.addContent(movie)
        }
    }
    
    private func shareMovie() {
        let title = movie.title ?? "Unknown Title"
        let overview = movie.overview ?? ""
        let shareText = "Check out this movie: \(title)\n\n\(overview)"
        
        let activityViewController = UIActivityViewController(
            activityItems: [shareText],
            applicationActivities: nil
        )
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityViewController, animated: true)
        }
    }
}

#Preview {
    NavigationView {
        MovieDetailsView(movie: Movie(
            id: 1,
            title: "Sample Movie",
            overview: "This is a sample movie overview",
            posterPath: "/sample.jpg",
            releaseDate: "2023-01-01",
            voteAverage: 8.5,
            voteCount: 1000,
            popularity: 85.5,
            originalLanguage: "en",
            genreIds: [1, 2, 3],
            adult: false,
            originalTitle: "Sample Movie",
            backdropPath: "/sample_backdrop.jpg",
            name: nil
        ))
    }
}
