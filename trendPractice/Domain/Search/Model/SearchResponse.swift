//
//  SearchResult.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

struct SearchResponse: Decodable {
    var page: Int
    var results: [Result]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
