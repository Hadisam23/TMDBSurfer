//
//  SearchView.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

// SearchBar.swift
import SwiftUI
import Kingfisher

struct SearchModalView: View {
    @ObservedObject var contentService: ContentService
    @Environment(\.presentationMode) var presentationMode
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchBar(searchText: $searchText) {
                    contentService.searchContent(query: searchText)
                }
                
                if contentService.isSearching {
                    VStack {
                        Spacer()
                        ProgressView("Searching...")
                        Spacer()
                    }
                } else if contentService.searchResults.isEmpty && !searchText.isEmpty {
                    VStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No results found")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                } else if !contentService.searchResults.isEmpty {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(contentService.searchResults) { result in
                                SearchResultCard(result: result)
                            }
                        }
                        .padding(.horizontal)
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Search for something...")
                            .font(.headline)
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Search")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}


struct SearchBar: View {
    @Binding var searchText: String
    let onSearchButtonClicked: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("Search movies and TV shows...", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .onSubmit {
                    onSearchButtonClicked()
                }
                .onChange(of: searchText) {
                    onSearchButtonClicked()
                }
        }
        .padding(.horizontal)
    }
}
