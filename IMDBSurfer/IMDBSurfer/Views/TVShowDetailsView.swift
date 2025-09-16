//
//  TVShowDetailsView.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import SwiftUI
import Kingfisher

struct TVShowDetailsView: View {
    let tvShow: TVShow
    @StateObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Backdrop Image
                KFImage(tvShow.fullBackdropURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                
                // Title
                Text(tvShow.displayTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                // Rating and Date
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", tvShow.voteAverage ?? 0.0))
                    }
                    
                    Spacer()
                    
                    Text(tvShow.formattedFirstAirDate)
                }
                .padding(.horizontal)
                
                // Action Buttons
                HStack(spacing: 12) {
                    Button(favoritesManager.isContentFavorite(tvShow) ? "Remove" : "Add to Favorites") {
                        toggleFavorite()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Share") {
                        shareTVShow()
                    }
                    .buttonStyle(.bordered)
                }
                .padding(.horizontal)
                
                // Overview
                VStack(alignment: .leading, spacing: 8) {
                    Text("Overview")
                        .font(.headline)
                        .padding(.horizontal)
                    
                    Text(tvShow.overview ?? "No overview available")
                        .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func toggleFavorite() {
        if favoritesManager.isContentFavorite(tvShow) {
            favoritesManager.removeContent(tvShow)
        } else {
            favoritesManager.addContent(tvShow)
        }
    }
    
    private func shareTVShow() {
        let title = tvShow.displayTitle
        let overview = tvShow.overview ?? ""
        let shareText = "Check out this TV show: \(title)\n\n\(overview)"
        
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
        TVShowDetailsView(tvShow: TVShow(
            id: 1,
            title: "Sample TV Show",
            overview: "This is a sample TV show overview",
            posterPath: "/sample.jpg",
            firstAirDate: "2023-01-01",
            voteAverage: 8.5,
            voteCount: 1000,
            popularity: 85.5,
            originalLanguage: "en",
            genreIds: [1, 2, 3],
            adult: false,
            originalName: "Sample TV Show",
            backdropPath: "/sample_backdrop.jpg",
            originCountry: ["US"],
            numberOfSeasons: 3,
            numberOfEpisodes: 24,
            status: "Ended",
            type: "Scripted",
            lastAirDate: "2023-12-01",
            releaseDate: nil,
            name: nil
        ))
    }
}
