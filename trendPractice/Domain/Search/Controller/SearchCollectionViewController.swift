//
//  SearchViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

import Alamofire
import Kingfisher

 
extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let resultList = data?.results else {
            return 0
        }
        
        return resultList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.identifier,
                                                      for: indexPath) as! SearchCollectionViewCell
        guard let resultList = data?.results else {
            return cell
        }
        
        let data = resultList[indexPath.row]
        cell.configCell(data)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            guard let resultList = data?.results, resultList.count - 2 == item.row,
                  let totalPages = data?.totalPages, page < totalPages,
                  let searchText = searchedWords.last else {
                return
            }
            
            page += 1
            print(#function, searchText, page)
            requestSearch(query: searchText , page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell
        
        let vc = DetailViewController()
        vc.contentsType = cell.contentsType
        vc.contentsId = cell.imageView.tag
        vc.contentsName = cell.contentsName
        pushAfterView(view: vc, backButton: true, animated: true)
    }
}
