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
        super.viewDidLoad()
        configBaseSetting()
    }
    
    override func configNavigationbar() {
        super.configNavigationbar()
        navigationItem.title = UIResource.Text.searchCollectionView.navigationTitle
        let barbuttonItem = UIBarButtonItem(image: UIResource.image.chevronLeft, style: .plain, target: self, action: #selector(goMainView))
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = barbuttonItem
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
        popToRootView(animated: false)
    }
    
    func requestSearch(query: String, page: Int) {
        let router = APIRouter.searchAPI(query: query, page: page)
        APIClient.request(SearchResponse.self, router: router) { search, error in
            guard error == nil, let search else {
                print(#function, error)
                return
            }
            self.updateData(response: search)
        }
    }
    
    func updateData(response: SearchResponse) {
        if self.data != nil {
            self.data?.page = response.page
            self.data?.results = response.results.filter { media in
                media.posterPath != nil && media.backdropPath != nil
            }
        } else {
            self.data = response
            let filteredResults = response.results.filter { media in
                media.posterPath != nil && media.backdropPath != nil
            }
            self.data?.results.append(contentsOf: filteredResults)
        }
    }
}
