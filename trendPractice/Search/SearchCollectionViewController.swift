//
//  SearchViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit
import Then
 

class SearchCollectionViewController: UIViewController {

    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
    }
    
    var movieLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.middle)
        $0.text = "추천 영화"
    }
    
    var tvLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.middle)
        $0.text = "추천 TV 시리즈"
    }
    
    
    lazy var movieCollectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionViewLayout())
    
    lazy var tvCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let itemCount: Double = 2
        let width: Double = UIScreen.main.bounds.width - 40.0
        layout.itemSize = CGSize(width: width/itemCount, height: 240)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        return layout
    }
    
    var movieParameters: Parameters = [
        TMDB.query.parameter: TMDB.query.parameterString
    ]
    
    var tvParameters: Parameters = [
        TMDB.query.parameter: TMDB.query.parameterString
    ]
    
    var movieSearchResult: SearchResult?
    var moviePage: Int = 1
    
    var tvSearchResult: SearchResult?
    var tvPage: Int = 1
    
    var size: Int = 20
    
    var initialKeyword = ["god"]

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSearching()
        configBaseSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    func configBaseSetting() {
        searchBar.delegate = self
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.prefetchDataSource = self
        movieCollectionView.register(SearchMediaCollectionViewCell.self,
                                forCellWithReuseIdentifier: SearchMediaCollectionViewCell.identifier)
        tvCollectionView.delegate = self
        tvCollectionView.dataSource = self
        tvCollectionView.prefetchDataSource = self
        tvCollectionView.register(SearchMediaCollectionViewCell.self,
                                  forCellWithReuseIdentifier: SearchMediaCollectionViewCell.identifier)
    }
}


extension SearchCollectionViewController: CodeBaseUI {
    func configHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(movieLabel)
        view.addSubview(movieCollectionView)
        view.addSubview(tvLabel)
        view.addSubview(tvCollectionView)
    }
    
    func configLayout() {
        searchBar.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(5)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        movieLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        movieCollectionView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.equalTo(movieLabel.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tvLabel.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.top.equalTo(movieCollectionView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tvCollectionView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.equalTo(tvLabel.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func configUI() {
        view.backgroundColor = .white
        navigationItem.title = UIResource.Text.searchCollectionView.navigationTitle
//        collectionView.backgroundColor = .green
    }
}

extension SearchCollectionViewController: AlamofireRequest {
    func initialSearching() {
        
        movieParameters["query"] = initialKeyword.first
        movieParameters["page"] = moviePage
        tvParameters["query"] = initialKeyword.first
        tvParameters["page"] = tvPage
        
        callSearchMovieRequest()
        callSearchTVRequest()
    }
    
    func callSearchMovieRequest() {
        getHTTPRequest(URL: TMDB.searchMovieAPI.URL,
                       parameters: movieParameters,
                       headers: MyAuth.headers,
                       decodingType: SearchResult.self,
                       callback: {(data: SearchResult)->() in
                            
                            if self.moviePage > data.totalPages {
                                return
                            }
                            
                            if self.moviePage == 1 {
                                self.movieSearchResult = data
                                self.movieCollectionView.reloadData()
                                self.movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                                 at: .left, animated: true)
                            } else {
                                self.movieSearchResult?.results.append(contentsOf: data.results)
                                self.movieCollectionView.reloadData()
                            }
                       })
    }
    
    func callSearchTVRequest() {
        getHTTPRequest(URL: TMDB.searchTVAPI.URL,
                       parameters: tvParameters,
                       headers: MyAuth.headers,
                       decodingType: SearchResult.self,
                       callback: {(data: SearchResult) -> () in
                            if self.tvPage > data.totalPages {
                                return
                            }
                            
                            if self.tvPage == 1 {
                                self.tvSearchResult = data
                                self.tvCollectionView.reloadData()
                                self.tvCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
                                                                 at: .left, animated: true)
                            } else {
                                self.tvSearchResult?.results.append(contentsOf: data.results)
                                self.tvCollectionView.reloadData()
                            }
                       })
    }
    
}


extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.text = nil
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           searchText.count > 1, Set(searchText).count > 1 {
            moviePage = 1
            tvPage = 1
            
            movieParameters["page"] = moviePage
            movieParameters["query"] = searchText
            tvParameters["page"] = tvPage
            tvParameters["query"] = searchText
        
            movieLabel.text = "'\(searchText)' 관련 영화"
            tvLabel.text = "'\(searchText)' 관련 TV 시리즈"
            
            callSearchMovieRequest()
            callSearchTVRequest()
            
            searchBar.resignFirstResponder()
        } else {
            searchBar.text = "검색어가 올바르지 않습니다."
        }
    }
}


extension SearchCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == movieCollectionView {
            if let resultList = movieSearchResult?.results {
                return resultList.count
            } else {
                return 1
            }
        } else {
            if let resultList = tvSearchResult?.results {
                return resultList.count
            } else {
                return 1
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchMediaCollectionViewCell.identifier,
                                                      for: indexPath) as! SearchMediaCollectionViewCell
        
        if collectionView == movieCollectionView {
            if let resultList = movieSearchResult?.results {
                let data = resultList[indexPath.row]
                cell.configCell(data)
            }
        } else {
            if let resultList = tvSearchResult?.results {
                let data = resultList[indexPath.row]
                cell.configCell(data)
            }
        }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for item in indexPaths {
            if collectionView == movieCollectionView {
                if let resultList = movieSearchResult?.results, resultList.count - 2 == item.row,
                   let totalPages = movieSearchResult?.totalPages, moviePage < totalPages {
                    moviePage += 1
                    callSearchMovieRequest()
                }
            } else {
                if let resultList = tvSearchResult?.results, resultList.count - 2 == item.row,
                   let totalPages = tvSearchResult?.totalPages, tvPage < totalPages {
                    tvPage += 1
                    callSearchTVRequest()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
    
}
