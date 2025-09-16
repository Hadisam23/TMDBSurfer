//
//  MoviesView.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

import SwiftUI

struct MoviesView: View {
    @StateObject private var contentService = ContentService()
    @StateObject private var themeManager = ThemeManager.shared
    @State private var showingSearchModal = false
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Movies Tab
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            HorizontalContentList(
                                title: "Popular Movies",
                                content: contentService.popularMovies
                            )
                            
                            HorizontalContentList(
                                title: "Top Rated Movies",
                                content: contentService.topRatedMovies
                            )
                            
                            HorizontalContentList(
                                title: "Now Playing",
                                content: contentService.nowPlayingMovies
                            )
                        }
                    }
                    .padding(.vertical)
                }
                .navigationTitle("Movies")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            themeManager.toggleTheme()
                        }) {
                            Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Search") {
                            showingSearchModal = true
                        }
                        .foregroundColor(.blue)
                    }
                }
                .onAppear {
                    contentService.fetchAllContent()
                }
            }
            .tabItem {
                Image(systemName: "film")
                Text("Movies")
            }
            .tag(0)
            
            // TV Shows Tab
            NavigationView {
                ScrollView {
                    VStack(spacing: 24) {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            HorizontalContentList(
                                title: "Popular TV Shows",
                                content: contentService.popularTVShows
                            )
                            
                            HorizontalContentList(
                                title: "Top Rated TV Shows",
                                content: contentService.topRatedTVShows
                            )
                            
                            HorizontalContentList(
                                title: "On The Air",
                                content: contentService.onTheAirTVShows
                            )
                        }
                    }
                    .padding(.vertical)
                }
                .navigationTitle("TV Shows")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            themeManager.toggleTheme()
                        }) {
                            Image(systemName: themeManager.isDarkMode ? "sun.max.fill" : "moon.fill")
                                .font(.title3)
                                .foregroundColor(.primary)
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Search") {
                            showingSearchModal = true
                        }
                        .foregroundColor(.blue)
                    }
                }
            }
            .tabItem {
                Image(systemName: "tv")
                Text("TV Shows")
            }
            .tag(1)
            
            // Favorites Tab
            FavoritesView()
                .tabItem {
                    Image(systemName: "heart")
                    Text("Favorites")
                }
                .tag(2)
        }
        .sheet(isPresented: $showingSearchModal) {
            SearchModalView(contentService: contentService)
        }
    }
}
