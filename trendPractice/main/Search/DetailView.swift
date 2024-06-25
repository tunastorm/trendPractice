//
//  DetailView.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit

import SnapKit
import Then

class DetailView: UIView {

    var delegate: DetailViewDelegate?
    
    let tableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configHierarchy() {
        self.addSubview(tableView)
        
    }
    
    private func configLayout() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.headerView(forSection: 0)?.textLabel?.font = .boldSystemFont(ofSize: 30)
        tableView.headerView(forSection: 0)?.textLabel?.textColor = .black
    }
}
