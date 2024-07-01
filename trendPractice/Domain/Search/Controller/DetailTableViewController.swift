//
//  DetailTableViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return contentsName
//    }
    
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
        return imageVector.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        configCollectionView(cell: cell, indexPath: indexPath)
    
        if let mediaType, indexPath.row < imageVector.count-1 {
            cell.configCell(mediaType: mediaType, rowIndex: indexPath.row)
        } else if let mediaType {
            cell.titleLabel.text = UIResource.Text.detailViewPoster.label
        }
        
        cell.collectionView.reloadData()
        
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
}
