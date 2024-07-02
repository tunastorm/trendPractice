//
//  VideoResponse.swift
//  trendPractice
//
//  Created by 유철원 on 7/1/24.
//

import Foundation


struct VideoResponse: Decodable {
    var id: Int
    var results: [Video]
}

struct Video: Decodable, DetailViewImage {
    
    var key: String
    
    var imagePath: String? {
        return key
    }
}
