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
        
        print(#function, "\(page)/\(data?.totalPages) | \(searchedWords.last) | \(Int((data?.results.count ?? 0) / 3) * 3)")
        
        for item in indexPaths {
            print(#function, item.row)
            guard let resultList = data?.results,
                  let totalPages = data?.totalPages, page < totalPages,
                  let searchText = searchedWords.last else {
                print(#function, "scroll cancled")
                return
            }
            
            let minus = resultList.count % 3 == 0 ? 3 : resultList.count % 3
            if resultList.count - minus <= item.row {
                page += 1
                requestSearch(query: searchText, page: page)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SearchCollectionViewCell
        
        let vc = DetailViewController()
        vc.mediaType = cell.contentsType
        vc.contentsId = cell.imageView.tag
        vc.contentsName = cell.contentsName
        pushAfterView(view: vc, backButton: true, animated: true)
    }
}
