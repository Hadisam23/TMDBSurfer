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
    @StateObject private var contentService = ContentService()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                KFImage(movie.fullPosterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                
                Text(movie.title ?? "Unknown Title")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", movie.voteAverage ?? 0.0))
                    }
                    
                    Spacer()
                    
                    Text(movie.releaseDate ?? "")
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: favoritesManager.isContentFavorite(movie) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(favoritesManager.isContentFavorite(movie) ? .red : .primary)
                            .frame(width: 50, height: 50)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        openTrailer()
                    }) {
                        Image(systemName: "play.circle")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 50, height: 50)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        shareMovie()
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title2)
                            .foregroundColor(.primary)
                            .frame(width: 50, height: 50)
                            .background(Color(.systemGray6))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                
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
    
    private func openTrailer() {
        contentService.getTrailerURL(for: movie.id) { url in
            if let url = url {
                UIApplication.shared.open(url)
            }
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
