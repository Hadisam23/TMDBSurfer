//
//  ImageConfiguration.swift
//  IMDBSurfer
//
//  Created by Hadi Samara on 15/09/2025.
//

import Kingfisher
import SwiftUI

struct ImageConfiguration {
    static func setup() {
        // Configure cache
        let cache = KingfisherManager.shared.cache
        cache.memoryStorage.config.totalCostLimit = 100 * 1024 * 1024 // 100 MB
        cache.memoryStorage.config.expiration = .seconds(300) // 5 minutes
        cache.diskStorage.config.sizeLimit = 500 * 1024 * 1024 // 500 MB
        cache.diskStorage.config.expiration = .days(7) // 7 days

        // Configure downloader
        let downloader = ImageDownloader.default
        downloader.downloadTimeout = 15.0

        // Configure processor for better performance
        let processor = DownsamplingImageProcessor(size: CGSize(width: 300, height: 450))
        KingfisherManager.shared.defaultOptions = [
            .processor(processor)
        ]
    }
}
