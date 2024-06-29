//
//  DetailTableViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


extension DetailViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contentsName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.identifier, for: indexPath) as! DetailTableViewCell
        cell.collectionView.delegate = self
        cell.collectionView.dataSource = self
        cell.collectionView.prefetchDataSource = self
        cell.collectionView.register(DetailCollectionViewCell.self,
                      forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        cell.collectionView.tag = indexPath.row
        cell.collectionView.backgroundColor = .clear
        
        if let contentsType, indexPath.row < resultsList.count {
            cell.configCell(contentsType: contentsType, rowIndex: indexPath.row)
        } else {
            cell.titleLabel.text = UIResource.Text.detailViewTitle.label
        }
        
        cell.collectionView.reloadData()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        
    }
}
