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
    }
    
    var tvLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.middle)
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
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        
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
    
    var isInitialSearch = true
    var initialKeyword = ["god"]
    var searchedWords: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
//        initialSearching()
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
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tvLabel.snp.makeConstraints{
            $0.height.equalTo(30)
            $0.top.equalTo(movieCollectionView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        tvCollectionView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.equalTo(tvLabel.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configUI() {
        setDefaultUI()
        view.backgroundColor = .white
        navigationItem.title = UIResource.Text.searchCollectionView.navigationTitle
        let barbuttonItem = UIBarButtonItem(image: UIResource.image.chevronLeft, style: .plain, target: self, action: #selector(goMainView))
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = barbuttonItem
    }
    
    @objc func goMainView() {
        popToRootView(animated: false)
    }
}
//
//extension SearchCollectionViewController: AlamofireRequest {
//    func initialSearching() {
//        let fastSearched = UserDefaultHelper.standard.searchedWords
//        print(#function, "fastSearched: \(fastSearched)")
//        
//        searchedWords = UserDefaultHelper.standard.searchedWords
//        
//        if searchedWords.count > 0 {
//            initialKeyword = searchedWords
//        } else {
//            initialKeyword = UserDefaultHelper.standard.recommandedWords
//        }
//        
//        let searchWord = initialKeyword.randomElement()
//        
//        movieParameters["query"] = searchWord
//        movieParameters["page"] = moviePage
//        tvParameters["query"] = searchWord
//        tvParameters["page"] = tvPage
//        
//        callSearchMovieRequest()
//        callSearchTVRequest()
//    }
//    
//    func callSearchMovieRequest() {
//        getHTTPRequest(URL: TMDB.searchMovieAPI.getURL,
//                       parameters: movieParameters,
//                       headers: MyAuth.headers,
//                       decodingType: SearchResult.self,
//                       callback: {(data: SearchResult)->() in
//            
//                            if self.moviePage > data.totalPages {
//                                return
//                                
//                            } else if data.results.count == 0 {
//                                return
//                            
//                            } else if self.moviePage == 1  {
//                                self.movieSearchResult = data
//                                self.movieCollectionView.reloadData()
//                                self.movieCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
//                                                                      at: .right, animated: true)
//                            } else {
//                                self.movieSearchResult?.results.append(contentsOf: data.results)
//                                self.movieCollectionView.reloadData()
//                            }
//                            if self.isInitialSearch, self.searchedWords.count > 0, let lastWord = self.searchedWords.last {
//                                self.movieLabel.text = "최근 검색어 '\(lastWord)' 관련 영화"
//                               
//                            } else {
//                                self.movieLabel.text = "'\(self.movieParameters["query"]!)' 관련 영화"
//                             
//                           }
//                       })
//    }
//    
//    
//    func callSearchTVRequest() {
//        getHTTPRequest(URL: TMDB.searchTVAPI.getURL,
//                       parameters: tvParameters,
//                       headers: MyAuth.headers,
//                       decodingType: SearchResult.self,
//                       callback: {(data: SearchResult) -> () in
//                            if self.tvPage > data.totalPages {
//                                return
//                                
//                            } else if data.results.count == 0 {
//                                return
//                                
//                            } else if self.tvPage == 1 {
//                                self.tvSearchResult = data
//                                self.tvCollectionView.reloadData()
//                                self.tvCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0),
//                                                                   at: .right, animated: true)
//                            } else {
//                                self.tvSearchResult?.results.append(contentsOf: data.results)
//                                self.tvCollectionView.reloadData()
//                            }
//                            
//                            if self.isInitialSearch, self.searchedWords.count > 0, let lastWord = self.searchedWords.last {
//                                self.tvLabel.text = "최근 검색어 '\(lastWord)' 관련 TV 시리즈"
//                                self.isInitialSearch = false
//                            } else {
//                                self.tvLabel.text = "'\(self.tvParameters["query"]!)' 관련 TV 시리즈"
//                                self.isInitialSearch = false
//                           }
//                        })
//    }
//}


extension SearchCollectionViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.text = ""
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text,
           searchText.count > 1, Set(searchText).count > 1 {
            movieSearchResult = nil
            tvSearchResult = nil
            searchedWords.append(searchText)
            UserDefaultHelper.standard.searchedWords = searchedWords
            
            moviePage = 1
            tvPage = 1
            
            movieParameters["page"] = moviePage
            movieParameters["query"] = searchText
            tvParameters["page"] = tvPage
            tvParameters["query"] = searchText
            
//            callSearchMovieRequest()
//            callSearchTVRequest()
//            
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
        
        cell.delegate = self
        if collectionView == movieCollectionView {
            if let resultList = movieSearchResult?.results {
                let data = resultList[indexPath.row]
                cell.configCell(data, type: APIConstants.MediaType.movie)
            }
        } else {
            if let resultList = tvSearchResult?.results {
                let data = resultList[indexPath.row]
                cell.configCell(data, type: APIConstants.MediaType.tv)
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
                    movieParameters["page"] = moviePage
//                    callSearchMovieRequest()
                }
            } else {
                if let resultList = tvSearchResult?.results, resultList.count - 2 == item.row,
                   let totalPages = tvSearchResult?.totalPages, tvPage < totalPages {
                    tvPage += 1
                    tvParameters["page"] = tvPage
//                    callSearchTVRequest()
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}

extension SearchCollectionViewController: CellTransitionDelegate {
    func pushAfterViewType<T>(type: T.Type, backButton: Bool, animated: Bool, contents: (APIConstants.MediaType, Int, String)) where T : UIViewController {
        
        switch type {
        case is DetailViewController.Type:
            let vc = DetailViewController()
            vc.contentsType = contents.0
            vc.contentsId = contents.1
            vc.contentsName = contents.2
            pushAfterView(view: vc, backButton: backButton, animated: animated)
        default: return
        }
    }
}
