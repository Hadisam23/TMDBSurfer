//
//  FavoritesView.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import SwiftUI
import Kingfisher

struct FavoritesView: View {
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Picker("Content Type", selection: $selectedTab) {
                    Text("All").tag(0)
                    Text("Movies").tag(1)
                    Text("TV Shows").tag(2)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if selectedContent.isEmpty {
                    VStack(spacing: 16) {
                        Spacer()
                        Image(systemName: "heart")
                            .font(.system(size: 60))
                            .foregroundColor(.gray)
                        Text("No Favorites Yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                        Text("Tap the heart icon on any movie or TV show to add it to your favorites")
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                        Spacer()
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 12),
                            GridItem(.flexible(), spacing: 12)
                        ], spacing: 16) {
                            ForEach(selectedContent, id: \.id) { content in
                                FavoriteContentCard(content: content)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("My Favorites")
        }
    }
    
    private var selectedContent: [any ContentItem] {
        switch selectedTab {
        case 0:
            return favoritesManager.allFavorites
        case 1:
            return favoritesManager.favoriteMovies
        case 2:
            return favoritesManager.favoriteTVShows
        default:
            return []
        }
    }
}

struct FavoriteContentCard: View {
    let content: any ContentItem
    @ObservedObject private var favoritesManager = FavoritesManager.shared
    
    var body: some View {
        NavigationLink(destination: destinationView) {
            VStack(alignment: .leading, spacing: 8) {
                ZStack(alignment: .topTrailing) {
                    KFImage(content.fullPosterURL)
                        .resizable()
                        .aspectRatio(2/3, contentMode: .fill)
                        .frame(height: 240)
                        .cornerRadius(12)
                        .clipped()
                    
                    Button(action: {
                        toggleFavorite()
                    }) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                            .font(.title2)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(8)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(content.title ?? content.name ?? "Unknown Title")
                        .font(.headline)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(minHeight: 44)
                    
                    HStack(alignment: .center) {
                        Text(contentType)
                            .font(.caption)
                            .fontWeight(.medium)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(typeColor)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                        
                        Spacer()
                        
                        HStack(spacing: 2) {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                                .font(.caption)
                            Text(String(format: "%.1f", content.voteAverage ?? 0.0))
                                .font(.caption)
                                .fontWeight(.medium)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .frame(height: 70)
            }
            .frame(maxWidth: .infinity)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
        }
        .buttonStyle(PlainButtonStyle())
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
    
    private var contentType: String {
        if content is Movie {
            return "Movie"
        } else if content is TVShow {
            return "TV Show"
        } else if let searchResult = content as? SearchResult {
            return searchResult.mediaType?.capitalized ?? "Content"
        }
        return "Content"
    }
    
    private var typeColor: Color {
        if content is Movie {
            return .blue
        } else if content is TVShow {
            return .green
        } else if let searchResult = content as? SearchResult {
            return searchResult.isMovie ? .blue : .green
        }
        return .gray
    }
    
    private func toggleFavorite() {
        favoritesManager.removeContent(content)
    }
}

#Preview {
    FavoritesView()
}
