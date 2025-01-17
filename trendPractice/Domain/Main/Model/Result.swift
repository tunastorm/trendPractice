//
//  Result.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import Foundation


// MARK: - Result
struct Result: Decodable, DetailViewImage {
    let id: Int
    let mediaType: APIConstants.MediaType?
    let adult: Bool
    let title: String?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    let genreIDS: [Int]
    let releaseDate: String?
    let firstAirDate: String?
    let voteAverage: Double
    let overview: String

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case adult
        case title
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case overview
    }
    
    var imagePath: String? {
        return posterPath
    }
    
    func geTitle() -> String {
        return mediaType == .movie ? title ?? "" : name ?? ""
    }
    
    func getReleasDate() -> String {
        return mediaType == .movie ? releaseDate ?? "" : firstAirDate ?? ""
    }
    
    
}
