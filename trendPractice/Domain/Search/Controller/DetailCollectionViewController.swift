//
//  DetailViewControllerExtension.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageVector[collectionView.tag].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
        
        let tableRowIdx = collectionView.tag
        let itemIdx = indexPath.row
        
        guard let mediaType, imageVector[tableRowIdx].count > 0 else {
            return cell
        }
        let data = imageVector[tableRowIdx][itemIdx]
        cell.configCell(data: data, contentsType: mediaType)
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if collectionView.tag >= imageVector.count - 1 {
            return
        }
        
        let tableRowIdx = collectionView.tag
        let lastResponse = responseList[tableRowIdx]
        
        indexPaths.forEach { item in
            let imageList = imageVector[tableRowIdx]
            let totalPages = lastResponse.totalPages
            print(#function, "item: \(item.row)/ \(imageList.count) | page: \(lastResponse.page) / \(totalPages)")
            guard lastResponse.page < totalPages, imageList.count - 1 == item.row else {
                print(#function, "scroll canceld")
                return
            }
            switch tableRowIdx {
            case 0: requestSimilar(idx: tableRowIdx, page: lastResponse.page + 1)
            case 1: requestRecommandations(idx: tableRowIdx, page: lastResponse.page + 1)
            default: return
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
