
//
//  SearchResult.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

import Foundation

struct SearchResult: ContentItem, Identifiable {
    let id: Int
    let title: String?
    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let mediaType: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, overview, name
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case mediaType = "media_type"
    }
    
    var fullPosterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "\(Constants.imageBaseURL)\(posterPath)")
    }
    
    var isMovie: Bool {
        return mediaType == "movie"
    }
    
    var isTVShow: Bool {
        return mediaType == "tv"
    }
}
