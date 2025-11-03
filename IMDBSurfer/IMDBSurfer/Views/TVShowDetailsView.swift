//
//  TVShowDetailsView.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import SwiftUI
import Kingfisher

struct TVShowDetailsView: View {
    let tvShow: TVShow
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @StateObject private var contentService = ContentService()
    @State private var isShowingShareSheet = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                KFImage(tvShow.fullPosterURL)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 300)
                    .clipped()
                
                Text(tvShow.title ?? "")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack {
                    HStack {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", tvShow.voteAverage ?? 0.0))
                    }
                    
                    Spacer()
                    
                    Text(tvShow.firstAirDate ?? "")
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: favoritesManager.isContentFavorite(tvShow) ? "heart.fill" : "heart")
                            .font(.title2)
                            .foregroundColor(favoritesManager.isContentFavorite(tvShow) ? .red : .primary)
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
                        isShowingShareSheet = true
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
                    
                    Text(tvShow.overview ?? "No overview available")
                        .padding(.horizontal)
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isShowingShareSheet) {
            let title = tvShow.title ?? tvShow.name ?? "Unknown Title"
            let overview = tvShow.overview ?? ""
            let shareText = "Check out this TV show: \(title)\n\n\(overview)"
            ActivityView(activityItems: [shareText])
        }
    }
    
    private func toggleFavorite() {
        if favoritesManager.isContentFavorite(tvShow) {
            favoritesManager.removeContent(tvShow)
        } else {
            favoritesManager.addContent(tvShow)
        }
    }
    
    private func openTrailer() {
        contentService.getTVTrailerURL(for: tvShow.id) { url in
            if let url = url {
                UIApplication.shared.open(url)
            }
        }
    }
}
