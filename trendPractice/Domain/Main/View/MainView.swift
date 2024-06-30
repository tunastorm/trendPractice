//
//  MainView.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import UIKit


class MainView: BaseView {
    
    var delegate: ViewTransitionDelegate?
    
    let tableView = UITableView().then {
        $0.separatorInset = .zero
        $0.separatorStyle = .none
    }
    
    override func configHierarchy() {
        self.addSubview(tableView)
    }
    
    override func configLayout() {
        tableView.snp.makeConstraints{
            $0.edges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        super.configView()
    }
    
    func networkErrorEvent(error: APIError?) {
        error?.showToast()
    }
}
