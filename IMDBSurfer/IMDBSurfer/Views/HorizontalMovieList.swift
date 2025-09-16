//
//  HorizontalListView.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 13/09/2025.
//

// HorizontalMovieList.swift
import SwiftUI

struct HorizontalContentList<T: ContentItem>: View {
    let title: String
    let content: [T]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(content) { item in
                        ContentCard(content: item)
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
