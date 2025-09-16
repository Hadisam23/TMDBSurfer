//
//  ContentResponse.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Foundation

// Generic response wrapper
struct ContentResponse<T: Codable>: Codable {
    let results: [T]
}
