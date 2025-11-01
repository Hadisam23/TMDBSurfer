//
//  ContentResponse.swift
//  TMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

struct ContentResponse<T: Codable>: Codable {
    let results: [T]
}
