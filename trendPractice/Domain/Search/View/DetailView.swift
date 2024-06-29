//
//  DetailView.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit

import SnapKit
import Then

class DetailView: BaseView {

    let tableView = UITableView()
    
    override func configHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        self.backgroundColor = .white
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
    }
}
