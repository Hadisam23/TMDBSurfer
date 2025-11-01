//
//  SearchResponse.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

struct SearchResponse<T: Codable>: Codable {
    let results: [T]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
