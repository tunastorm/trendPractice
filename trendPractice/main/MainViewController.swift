//
//  MainViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit

import Alamofire
import SnapKit
import Then

class MainViewController: UIViewController {

    var dataList: [Result]?
    
    let tableView = UITableView().then {
        $0.separatorInset = .zero
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        setWeeklyTrendData()
        configTableViewSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        configData()
    }
    
    func configTableViewSetting() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainTableViewCell.self,
                           forCellReuseIdentifier: MainTableViewCell.identifier)
    }
}

extension MainViewController: AlamofireRequest {
    func setWeeklyTrendData() {
        let parameters: Parameters = [
            TMDB.language.parameter: TMDB.language.parameterString
        ]
        
        let headers: HTTPHeaders = [
            TMDB.Authorization.header : TMDB.Authorization.headerString,
            TMDB.accept.header: TMDB.accept.headerString
        ]

        getHTTPRequest(URL: TMDB.trendingAPIAllWeek.URL,
                       parameters: parameters,
                       headers: headers,
                       decodingType: Trending.self,
                       callback: { (data: Trending) -> () in
                           self.dataList = data.results
                           self.tableView.reloadData()
                        })
    }
    
    func configData() {
        
    }
    
    func updateData() {
        
    }
    
}

extension MainViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(tableView)
    }
    
    func configLayout() {
        tableView.snp.makeConstraints{
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        
    }
}

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
        
        guard let dataList else {return UITableViewCell()}
        
        let data = dataList[rowIndex]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        
        cell.configCell(data)
        
        return cell
    }
}
