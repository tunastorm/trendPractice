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
        
        let tableRowIdx = collectionView.tag
        let itemIdx = indexPath.row
        
        print(#function, mediaType, tableRowIdx)
        guard let mediaType, imageVector[tableRowIdx].count > 0 else {
            return UICollectionViewCell()
        }
        let data = imageVector[tableRowIdx][itemIdx]
        
        var cell: UICollectionViewCell?
        
        if collectionView.tag < imageVector.count - 1 {
            let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
            imageCell.configCell(data: data, mediaType: mediaType)
            cell = imageCell
        } else {
            let videoCell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewVideoCell.identifier, for: indexPath) as! DetailCollectionViewVideoCell
            videoCell.configCell(data: data, mediaType: mediaType)
            cell = videoCell
        }
        guard let cell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if collectionView.tag >= 2 {
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
