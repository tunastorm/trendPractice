//
//  Genre.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import Foundation



struct GenreList: Decodable {
    let genres: [Genre]
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decode([Genre].self, forKey: .genres)
    }
    
    enum CodingKeys: String, CodingKey {
        case genres
    }
}


struct Genre: Decodable {
    let id : Int
    let name : String
    
    enum CodingKeys: String, CodingKey {
       case id
       case name
    }
}
