//
//  MainDetailViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/27/24.
//

import UIKit

import Kingfisher


class MainDetailViewController: UIViewController {
    
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
    
    func setTableViewDelegate() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(MainDetailTableViewCell.self,
                                    forCellReuseIdentifier: MainDetailTableViewCell.identifier)
    }
    
    func setMovieData() {
        let baseURL = UIResource.Text.imageBaseURL
        guard let data, let backdrop = URL(string: baseURL + data.backdropPath), let poster = URL(string: baseURL + data.posterPath) else {
            print(#function, "noData")
            return
        }
        
        rootView.titleLabel.text = data.geTitle()
        rootView.titleView.kf.setImage(with: backdrop)
        rootView.posterView.kf.setImage(with: poster)
        rootView.overViewContentsLabel.text = data.overview
    }
    
    func setCastData() {
        guard let data else {
            return
        }
        let router = APIRouter.creditsAPI(contentsType: data.mediaType, contentsId: data.id)
        TMDBModel.shared.requestTMDB(responseType: Credits.self, router: router) { credits, error in
            guard error == nil, let credits else {
                print(#function, error)
                return
            }
            
            self.castData = credits.cast.filter { cast in
                cast.character != nil
            }
            print(#function, self.castData)
        }
    }
}

