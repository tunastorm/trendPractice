//
//  TrendingALL.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import Foundation

struct Trending: Decodable {
    let page: Int
    let results: [Result]
    let totalPages, totalResults: Int
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        page = (try? values.decode(Int.self, forKey: .page)) ?? 0
        results = (try? values.decode([Result].self, forKey: .results)) ?? []
        totalPages = (try? values.decode(Int.self, forKey: .totalPages)) ?? 0
        totalResults = (try? values.decode(Int.self, forKey: .totalResults)) ?? 0
    }
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Result: Decodable {
    let backdropPath: String
    let id: Int
    let originalTitle: String?
    let overview, posterPath: String
    let mediaType: MediaType
    let adult: Bool
    let title: String?
    let originalLanguage: OriginalLanguage
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double
    let voteCount: Int
    let originalName, name, firstAirDate: String?
    let originCountry: [String]?
    
    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        backdropPath = (try? values.decode(String.self, forKey: .backdropPath)) ?? ""
        id = (try? values.decode(Int.self, forKey: .id)) ?? 0
        if let originalTitle = (try? values.decode(String.self, forKey: .originalTitle)) {
            self.originalTitle = originalTitle
        } else {
            self.originalTitle = ""
        }
        overview = (try? values.decode(String.self, forKey: .overview)) ?? ""
        posterPath = (try? values.decode(String.self, forKey: .posterPath)) ?? ""
        mediaType = (try? values.decode(MediaType.self, forKey: .mediaType)) ?? Result.MediaType.movie
        adult = (try? values.decode(Bool.self, forKey: .adult)) ?? false
        title = (try? values.decode(String.self, forKey: .title)) ?? ""
        originalLanguage = (try? values.decode(OriginalLanguage.self, forKey: .originalLanguage)) ?? Result.OriginalLanguage.en
        genreIDS = (try? values.decode([Int].self, forKey: .genreIDS)) ?? []
        popularity = (try? values.decode(Double.self, forKey: .popularity)) ?? 0.0
        if let releaseDate = (try? values.decode(String.self, forKey: .releaseDate)) {
            self.releaseDate = releaseDate
        } else {
            self.releaseDate = ""
        }
        video = (try? values.decode(Bool.self, forKey: .video)) ?? false
        voteAverage = (try? values.decode(Double.self, forKey: .voteAverage)) ?? 0.0
        voteCount = (try? values.decode(Int.self, forKey: .voteAverage)) ?? 0
        if let originalName = (try? values.decode(String.self, forKey: .originalName)) {
            self.originalName = originalName
        } else {
            self.originalName = ""
        }
        if let name = (try? values.decode(String.self, forKey: .name)) {
            self.name = name
        } else {
            self.name = ""
        }
        if let firstAirDate = (try? values.decode(String.self, forKey: .firstAirDate)) {
            self.firstAirDate = firstAirDate
        } else {
            self.firstAirDate = ""
        }
        if let originCountry = (try? values.decode([String].self, forKey: .originCountry)) {
            self.originCountry = originCountry
        } else {
            self.originCountry = []
        }
    }

    enum CodingKeys: String, CodingKey, Decodable {
        case backdropPath = "backdrop_path"
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case adult, title
        case originalLanguage = "original_language"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalName = "original_name"
        case name
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
    
    enum MediaType: String, Decodable {
        case movie = "movie"
        case tv = "tv"
    }

    enum OriginalLanguage: String, Decodable {
        case en = "en"
        case fr = "fr"
        case ja = "ja"
        case zh = "zh"
    }
}
