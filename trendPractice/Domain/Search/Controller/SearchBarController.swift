//
//  SearchBarController.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import UIKit


extension SearchViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           searchText.count > 1, Set(searchText).count > 1 {
            data = nil
            
            if !searchedWords.contains(searchText) {
                searchedWords.append(searchText)
                UserDefaultHelper.standard.searchedWords = searchedWords
            }
            
            page = 1
            requestSearch(query: searchText, page: page)
            
            searchBar.resignFirstResponder()
        } else {
            searchBar.text = "검색어가 올바르지 않습니다."
        }
    }
}
