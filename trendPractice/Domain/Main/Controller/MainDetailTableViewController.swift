//
//  MainDetailTableViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/27/24.
//

import UIKit


extension MainDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return castData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainDetailTableViewCell.identifier, for: indexPath) as! MainDetailTableViewCell
        
        let data = castData[indexPath.row]
        
        cell.configCell(data: data)
        
        return cell
    }
}
