//
//  ContentService.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

class ContentService: ObservableObject {
    
    // Movies
    @Published var popularMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []
    @Published var nowPlayingMovies: [Movie] = []
    
    // TV Shows
    @Published var popularTVShows: [TVShow] = []
    @Published var topRatedTVShows: [TVShow] = []
    @Published var onTheAirTVShows: [TVShow] = []
    
    // Search
    @Published var searchResults: [SearchResult] = []
    @Published var isSearching = false
    
    private let session = URLSession.shared
    
    func fetchAllContent() {
        fetchMovies()
        fetchTVShows()
    }
    
    // MARK: - Search
    func searchContent(query: String) {
        guard !query.isEmpty else {
            searchResults = []
            return
        }
        
        isSearching = true
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let url = URL(string: "\(Constants.baseURL)/search/multi?api_key=\(Constants.tmdbAPIKey)&query=\(encodedQuery)")!
        
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(SearchResponse<SearchResult>.self, from: data)
                    DispatchQueue.main.async {
                        self.searchResults = response.results
                        self.isSearching = false
                    }
                } catch {
                    print("Error decoding search results: \(error)")
                    DispatchQueue.main.async {
                        self.isSearching = false
                    }
                }
            }
        }.resume()
    }
    
    func resetSearch() {
        searchResults = []
        isSearching = false
    }
    
    // MARK: - Generic Content Fetching
    private func fetchContent<T: ContentItem>(
        endpoint: String,
        completion: @escaping ([T]) -> Void
    ) {
        let url = URL(string: "\(Constants.baseURL)/\(endpoint)?api_key=\(Constants.tmdbAPIKey)")!
        
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(ContentResponse<T>.self, from: data)
                    DispatchQueue.main.async {
                        completion(response.results)
                    }
                } catch {
                    print("Error decoding \(endpoint): \(error)")
                }
            }
        }.resume()
    }
    
    // MARK: - Movies
    func fetchMovies() {
        fetchContent(endpoint: "movie/popular") { self.popularMovies = $0 }
        fetchContent(endpoint: "movie/top_rated") { self.topRatedMovies = $0 }
        fetchContent(endpoint: "movie/now_playing") { self.nowPlayingMovies = $0 }
    }
    
    // MARK: - TV Shows
    func fetchTVShows() {
        fetchContent(endpoint: "tv/popular") { self.popularTVShows = $0 }
        fetchContent(endpoint: "tv/top_rated") { self.topRatedTVShows = $0 }
        fetchContent(endpoint: "tv/on_the_air") { self.onTheAirTVShows = $0 }
    }
    
    // MARK: - Trailers
    func getTrailerURL(for movieId: Int, completion: @escaping (URL?) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/movie/\(movieId)/videos?api_key=\(Constants.tmdbAPIKey)")!
        
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                    let trailer = response.results.first { video in
                        video.type == "Trailer" && video.site == "YouTube"
                    }
                    DispatchQueue.main.async {
                        if let trailer = trailer {
                            completion(URL(string: "https://www.youtube.com/watch?v=\(trailer.key)"))
                        } else {
                            completion(nil)
                        }
                    }
                } catch {
                    print("Error decoding trailer: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }.resume()
    }
    
    func getTVTrailerURL(for tvId: Int, completion: @escaping (URL?) -> Void) {
        let url = URL(string: "\(Constants.baseURL)/tv/\(tvId)/videos?api_key=\(Constants.tmdbAPIKey)")!
        
        session.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(VideoResponse.self, from: data)
                    let trailer = response.results.first { video in
                        video.type == "Trailer" && video.site == "YouTube"
                    }
                    DispatchQueue.main.async {
                        if let trailer = trailer {
                            completion(URL(string: "https://www.youtube.com/watch?v=\(trailer.key)"))
                        } else {
                            completion(nil)
                        }
                    }
                } catch {
                    print("Error decoding TV trailer: \(error)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }
        }.resume()
    }
}

// MARK: - Video Models
struct VideoResponse: Codable {
    let results: [Video]
}

struct Video: Codable {
    let key: String
    let name: String
    let site: String
    let type: String
}
