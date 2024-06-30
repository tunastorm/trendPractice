//
//  SearchViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import UIKit


class SearchViewController: BaseViewController {
    
    let rootView = SearchView()
    
    var data: SearchResponse? {
        didSet {
            rootView.collectionView.reloadData()
        }
    }
    var page: Int = 1
    var searchedWords: [String] = []
    
    override func loadView() {
        view = rootView
    }
    
    override func viewDidLoad() {
        configBaseSetting()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationbar(navigationColor: .black)
    }
    
    override func configNavigationbar(navigationColor: UIColor) {
        super.configNavigationbar(navigationColor: navigationColor)
        navigationItem.title = UIResource.Text.searchCollectionView.navigationTitle
    }
    
    func configBaseSetting() {
        rootView.searchBar.delegate = self
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
        rootView.collectionView.prefetchDataSource = self
        rootView.collectionView.register(SearchCollectionViewCell.self,
                                forCellWithReuseIdentifier: SearchCollectionViewCell.identifier)
    }
    
    @objc func goMainView() {
        navigationItem.leftBarButtonItem?.isHidden = true
        popToRootView(animated: true)
    }
    
    func requestSearch(query: String, page: Int) {
        let router = APIRouter.searchAPI(query: query, page: page)
        APIClient.request(SearchResponse.self, router: router) { search, error in
            guard error == nil, let search else {
                self.rootView.networkErrorEvent(error: error)
                return
            }
            guard search.results.count > 0 else {
                self.rootView.networkErrorEvent(error: APIError.noResultError)
                return
            }
            self.updateData(response: search)
        }
    }
    
    func updateData(response: SearchResponse) {
        if self.data != nil {
            self.data?.page = response.page
            self.data?.results.append(contentsOf: response.results)
        } else {
            self.data = response
        }
    }
}
