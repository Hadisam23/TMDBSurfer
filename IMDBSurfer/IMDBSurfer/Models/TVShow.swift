//
//  TVShow.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

struct TVShow: ContentItem {

    let id: Int
    let title: String?
    let overview: String?
    let posterPath: String?
    let firstAirDate: String?
    let voteAverage: Double?
    var releaseDate: String?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview, title
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
    }
    
    // Protocol conformance
    
    var fullPosterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "\(Constants.imageBaseURL)\(posterPath)")
    }
}
