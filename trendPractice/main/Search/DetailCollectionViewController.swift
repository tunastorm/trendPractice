//
//  DetailViewControllerExtension.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tableRowIdx = collectionView.tag
        let itemSize = tableRowIdx  < resultsList.count ? resultsList[tableRowIdx].count : imageList.count
        print(#function, itemSize)
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
        
        let tableRowIdx = collectionView.tag
        let itemIdx = indexPath.row
    
        print(#function, "1")
        
        guard let contentsType else {return cell}
        
        print(#function, "2", tableRowIdx)
        switch tableRowIdx < resultsList.count {
        case true:  cell.configCell(data: resultsList[tableRowIdx][itemIdx], contentsType: contentsType)
        case false:  cell.configCell(data: imageList[itemIdx], contentsType: contentsType)
        }
        
        print(#function, "3")
   
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
