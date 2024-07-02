//
//  DetailTableViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = UITableView.automaticDimension
        if imageVector[indexPath.row].count == 0 {
            height = 0
        }
        return height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = DetailTableHeaderView()
        headerView.titleLabel.text = contentsName
        return headerView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function, imageVector.count)
        print(#function, imageVector)
        return imageVector.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, mediaType, indexPath.row)
        guard let mediaType else {
            return UITableViewCell()
        }
        
        var cell: UITableViewCell?
        print(#function, indexPath.row)
        if indexPath.row < imageVector.count - 1 {
            let imageCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
            imageCell.configCell(mediaType: mediaType, rowIndex: indexPath.row)
            configCollectionView(cell: imageCell, indexPath: indexPath)
            imageCell.collectionView.reloadData()
            cell = imageCell
        } else {
            let videoCell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewVideoCell.identifier, for: indexPath) as! DetailTableViewVideoCell
            videoCell.configCell(rowIdx: indexPath.row)
            configCollectionView(cell: videoCell, indexPath: indexPath)
            videoCell.collectionView.reloadData()
        }
       
        guard let cell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func configCollectionView(cell: DetailTableViewCell, indexPath: IndexPath) {
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.prefetchDataSource = self
        cell.collectionView.register(DetailCollectionViewCell.self,
                      forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
    }
    
    func configCollectionView(cell: DetailTableViewVideoCell, indexPath: IndexPath) {
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.prefetchDataSource = self
        cell.collectionView.register(DetailCollectionViewVideoCell.self,
                      forCellWithReuseIdentifier: DetailCollectionViewVideoCell.identifier)
        cell.collectionView.tag = indexPath.row
    }
}
