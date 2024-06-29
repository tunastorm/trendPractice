//
//  Genre.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import Foundation



struct GenreResponse: Decodable {
    let genres: [Genre]
}

struct Genre: Decodable {
    let id : Int
    let name : String
    
    enum CodingKeys: String, CodingKey {
       case id
       case name
    }
}
