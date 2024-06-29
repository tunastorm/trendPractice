//
//  MainTableViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import UIKit



extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dataList {
            return dataList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let rowIndex = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        guard let dataList else {
            return cell
        }
        
        let data = dataList[rowIndex]
        
        guard let mediaType = data.mediaType else {
            return cell
        }
        // 최초 1회에 한해 Cast 데이터 request
        if castDict[mediaType]?[data.id] == nil {
            setCreditsData(contentsType: mediaType, contentsId: data.id, indexPath: indexPath)
        }
    
        cell.configTrendingData(data)
        
        guard let genreList = genreDict[mediaType] else {return cell}
   
        var thisGenres: [Genre] = []
        var copyIDS = data.genreIDS
        
        for genre in genreList {
            if copyIDS.count > 0, copyIDS.contains(genre.id) {
                thisGenres.append(genre)
                guard let idx = copyIDS.firstIndex(of: genre.id) else { return cell }
                copyIDS.remove(at: idx)
            }
        }
        
        cell.configGenreData(thisGenres)

        guard let cast = castDict[mediaType]?[data.id] else {
            return cell
        }
        
        cell.configCastData(data: cast)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dataList else {
            return
        }
        
        let data = dataList[indexPath.row]
        let mainDetailVC = MainDetailViewController()
        mainDetailVC.data = data
        pushAfterView(view: mainDetailVC, backButton: true, animated: true)
    }
}

