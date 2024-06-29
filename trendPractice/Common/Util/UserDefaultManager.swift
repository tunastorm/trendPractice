//
//  UserDefaultManager.swift
//  trendPractice
//
//  Created by 유철원 on 6/12/24.
//

import Foundation


class UserDefaultHelper {
    private init() { }
    
    static let standard = UserDefaultHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case searchedWords, recomandedWords
    }
    
    var searchedWords: [String] {
        get {
            return userDefaults.array(forKey: Key.searchedWords.rawValue) as? [String] ?? []
        }
        set {
            userDefaults.set(newValue, forKey: Key.searchedWords.rawValue)
        }
    }
    
    var recommandedWords: [String] {
        get {
            return userDefaults.array(forKey: Key.recomandedWords.rawValue) as? [String] ?? ["액션", "드라마", "코미디"]
        }
        set {
            userDefaults.set(newValue, forKey: Key.recomandedWords.rawValue)
        }
    }
}
