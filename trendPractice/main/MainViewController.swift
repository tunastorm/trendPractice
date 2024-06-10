//
//  MainViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit
import Alamofire
import SnapKit

class MainViewController: UIViewController {

    var data: [Result]?
    
    let tableView = UITableView()
    
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
                           self.data = data.results
//                           print(#function, "data: \(self.data)")
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
        view.backgroundColor = .white
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let data {
            return data.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
}
