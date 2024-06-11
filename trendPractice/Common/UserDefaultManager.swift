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
        case searchedWord, recomandedWord
    }
    
    var searchedWord: [String] {
        get {
            return userDefaults.array(forKey: Key.searchedWord.rawValue) as! [String]
        }
        set {
            userDefaults.set(newValue, forKey: Key.searchedWord.rawValue)
        }
    }
    
    var recommandedWord: [String] {
        get {
            return userDefaults.array(forKey: Key.recomandedWord.rawValue) as! [String]
        }
        set {
            userDefaults.set(newValue, forKey: Key.recomandedWord.rawValue)
        }
    }
}
