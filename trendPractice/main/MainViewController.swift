//
//  MainViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit
import Alamofire

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        getTrendData()
    }
    
    func getTrendData() {
        let parameters: Parameters = [
            TMDB.language.parameter: TMDB.language.parameterString
        ]
        
        let headers: HTTPHeaders = [
            TMDB.Authorization.header : TMDB.Authorization.headerString,
            TMDB.accept.header: TMDB.accept.headerString
        ]
//        HTTPResponseString(.get, URL: TMDB.trendingAPIAllWeek.URL, parameters: parameters, headers: headers)
        getHTTPRequest(URL: TMDB.trendingAPIAllWeek.URL, 
                       parameters: parameters,
                       headers: headers,
                       decodingType: Trending.self,
                       callback: {}())
    }
    
    func updateData() {
        
    }
}

extension MainViewController: CodeBaseUI {
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
        
    }
}
