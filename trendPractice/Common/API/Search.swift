//
//  SearchResult.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

struct SearchResult: Decodable {
    let page: Int
    var results: [Result]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = (try? values.decode(Int.self, forKey: .page)) ?? 0
        results = (try? values.decode([Result].self, forKey: .results)) ?? []
        totalPages = (try? values.decode(Int.self, forKey: .totalPages)) ?? 0
        totalResults = (try? values.decode(Int.self, forKey: .totalResults)) ?? 0
    }
}
