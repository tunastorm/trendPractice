//
//  DetailViewControllerExtension.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit

extension DetailViewController: DetailViewDelegate {
        
}


extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemSize = 0
        if collectionView == self.detailView.similarCollectionView {
            itemSize = similarItemSize
        } else if collectionView == self.detailView.recommandCollectionView {
           itemSize = recommandItemSize
        }
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemIndex = indexPath.row
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCollectionViewCell.identifier, for: indexPath) as! DetailCollectionViewCell
        
        var data: Result?
        
        if collectionView == self.detailView.similarCollectionView {
            data = self.detailView.similarResults[itemIndex]
        } else if collectionView == self.detailView.recommandCollectionView {
            data = self.detailView.recommandResults[itemIndex]
        }
        
        guard let data, let contentsType else {return cell}
        
        cell.configCell(data: data, contentsType: contentsType)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        var itemSize: Int?
        if collectionView == self.detailView.similarCollectionView {
            itemSize = self.similarItemSize
        } else if collectionView == self.detailView.recommandCollectionView {
            itemSize = self.recommandItemSize
        }
        
        guard let itemSize else {return}
        
        indexPaths.forEach { indexPath in
            if itemSize - 2 == indexPath.row {
                
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
