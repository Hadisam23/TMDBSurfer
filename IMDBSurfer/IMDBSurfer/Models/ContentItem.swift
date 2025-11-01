//
//  ContentItem.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

protocol ContentItem: Codable, Identifiable {
    var id: Int { get }
    var title: String? { get }
    var name: String? { get }
    var overview: String? { get }
    var posterPath: String? { get }
    var releaseDate: String? { get }
    var voteAverage: Double? { get }
    var fullPosterURL: URL? { get }
}
