//
//  MainViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.


import UIKit

import Alamofire
import SnapKit
import Then


class MainViewController: BaseViewController {
    
    let rootView = MainView()

    var dataList: [Result]?
    var genreDict: [APIConstants.MediaType : [Genre]] = [.movie: [], .tv: []]
    var castDict: [APIConstants.MediaType : [Int:[Cast]]] = [.movie: [:], .tv: [:]]

    let searchVC = SearchViewController()
    
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setData()
        configRootView()
        configTableView()
    }
    
    override func configNavigationbar() {
        super.configNavigationbar()
        let barButtonItem = UIBarButtonItem(image: UIResource.image.magnifyingGlass,
                                            style: .plain, target: self, action:#selector(goSearchPage))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    func configRootView() {
        rootView.delegate = self
    }
    
    func configTableView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(MainTableViewCell.self,
                           forCellReuseIdentifier: MainTableViewCell.identifier)
    }
    
    func setData() {
        let group = DispatchGroup()
        let trending = APIRouter.trendingAPI(contentsType: .all, timeWindow: .week)
        let movieGenre = APIRouter.genreAPI(contentsType: .movie)
        let tvGenre = APIRouter.genreAPI(contentsType: .tv)
       
        
        group.enter()
        APIClient.request(TMDBResponse.self, router: trending) { trending, error in
            guard error == nil, let trending else {
                self.rootView.networkErrorEvent(error: error)
                group.leave()
                return
            }
            self.dataList = trending.results
            group.leave()
        }
        group.enter()
        APIClient.request(GenreResponse.self, router: movieGenre) { movieGenre, error in
            guard error == nil, let movieGenre else {
                self.rootView.networkErrorEvent(error: error)
                group.leave()
                return
            }
            self.genreDict[.movie] = movieGenre.genres
            group.leave()
        }
        group.enter()
        APIClient.request(GenreResponse.self, router: tvGenre) { tvGenre, error in
            guard error == nil, let tvGenre else {
                self.rootView.networkErrorEvent(error: error)
                group.leave()
                return
            }
            self.genreDict[.tv] = tvGenre.genres
            group.leave()
        }
        group.notify(queue: .main) {
            self.rootView.tableView.reloadData()
        }
    }
    
    func setCreditsData(contentsType: APIConstants.MediaType, contentsId: Int, indexPath: IndexPath) {
        let router = APIRouter.creditsAPI(contentsType: contentsType, contentsId: contentsId)
        APIClient.request(Credits.self, router: router) { credits, error in
            guard error == nil, let credits else {
                self.rootView.networkErrorEvent(error: error)
                return
            }
            self.castDict[contentsType]?[credits.id] = credits.cast
            self.rootView.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
    
    @objc func goSearchPage() {
        pushAfterView(view: searchVC, backButton: true, animated: true)
//        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootVCWithNavi(searchVC, animated: false)
    }
}
