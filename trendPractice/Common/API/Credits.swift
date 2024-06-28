//
//  Credits.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import Foundation

// MARK: - Welcome
struct Credits: Decodable {
    let cast, crew: [Cast]
    let id: Int
}

// MARK: - Cast
struct Cast: Decodable {
//    let gender, id: Int
    let name: String
    let profilePath: String?
    let character: String?
//    let creditID: String
//    let order: Int?
    
    enum CodingKeys: String, CodingKey {
        case name
//        case originalName = "original_name"
        case profilePath = "profile_path"
        case character
//        case creditID = "credit_id"
    }
}
