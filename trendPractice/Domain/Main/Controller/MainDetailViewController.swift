//
//  MainDetailViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/27/24.
//

import UIKit

import Kingfisher


class MainDetailViewController: BaseViewController {
    
    var data: Result?
    
    var router: APIRouter?
    
    let rootView = MainDetailView()
    
    var castData: [Cast] = [] {
        didSet {
            rootView.tableView.reloadData()
        }
    }
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        setMovieData()
        setCastData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func configNavigationbar() {
        super.configNavigationbar()
        navigationItem.title = UIResource.Text.mainDetailView.navigationTitle
    }
    
    func setTableViewDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(MainDetailTableViewCell.self,
                                    forCellReuseIdentifier: MainDetailTableViewCell.identifier)
    }
    
    func setMovieData() {
        let baseURL = UIResource.Text.imageBaseURL
        guard let data else {
            print(#function, "noData")
            return
        }
        
        if let backpropPath = data.backdropPath {
            let backdrop = URL(string: baseURL + backpropPath)
            rootView.titleView.kf.setImage(with: backdrop)
        }
        
        if let posterPath = data.posterPath {
            let poster = URL(string: baseURL + posterPath)
            rootView.posterView.kf.setImage(with: poster)
        }
    
        rootView.titleLabel.text = data.geTitle()
        rootView.overViewContentsLabel.text = data.overview
    }
    
    func setCastData() {
        guard let data, let mediaType = data.mediaType else {
            return
        }
        let router = APIRouter.creditsAPI(contentsType: mediaType, contentsId: data.id)
        APIClient.request(Credits.self, router: router) { credits, error in
            guard error == nil, let credits else {
                print(#function, error)
                return
            }
            self.castData = credits.cast.filter { cast in
                cast.character != nil
            }
        }
    }
}

