//
//  MovieCard.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

// MovieCard.swift
import SwiftUI
import Kingfisher

struct ContentCard<T: ContentItem>: View {
    let content: T
    @StateObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationLink(destination: destinationView) {
        VStack(alignment: .leading, spacing: 8) {
            // Poster with Favorite Button
            ZStack(alignment: .topTrailing) {
                KFImage(content.fullPosterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 225)
                .cornerRadius(12)
                .clipped()
                
                // Favorite Button
                Button(action: {
                    toggleFavorite()
                }) {
                    Image(systemName: favoritesManager.isContentFavorite(content) ? "heart.fill" : "heart")
                        .foregroundColor(favoritesManager.isContentFavorite(content) ? .red : .white)
                        .font(.title2)
                        .padding(8)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                }
                .padding(8)
            }
            
            // Title
            Text(content.title ?? content.name ?? "")
                .font(.headline)
                .lineLimit(2)
                .frame(width: 150, height: 50, alignment: .topLeading)
                .multilineTextAlignment(.leading)
            
            // Rating
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
                Text(String(format: "%.1f", content.voteAverage ?? ""))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .frame(height: 20)
        }
        .frame(width: 150)
        }
    }
    
    @ViewBuilder
    private var destinationView: some View {
        if let movie = content as? Movie {
            MovieDetailsView(movie: movie)
        } else if let tvShow = content as? TVShow {
            TVShowDetailsView(tvShow: tvShow)
        } else {
            Text("Details not available")
                .padding()
        }
    }
    
    private func toggleFavorite() {
        if favoritesManager.isContentFavorite(content) {
            favoritesManager.removeContent(content)
        } else {
            favoritesManager.addContent(content)
        }
    }
}
