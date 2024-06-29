//
//  TMDBResponse.swift
//  trendPractice
//
//  Created by 유철원 on 6/24/24.
//

import Foundation

struct TMDBResponse: Decodable {
    var page: Int
    var results: [Result]?
    var totalPages: Int
    var totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
