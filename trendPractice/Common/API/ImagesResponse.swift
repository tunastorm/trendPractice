//
//  ImagesResponse.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import Foundation


struct ImagesResponse: Decodable {
    var id: Int
//    var backdrops: [Backdrop]
    var posters: [Poster]
}


struct Backdrop: Decodable {
    var path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "file_path"
    }
}


struct Poster: Decodable {
    var path: String
    
    enum CodingKeys: String, CodingKey {
        case path = "file_path"
    }
}
