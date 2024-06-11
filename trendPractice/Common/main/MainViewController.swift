//
//  MainViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.


import UIKit

import Alamofire
import SnapKit
import Then

class MainViewController: UIViewController {

    var dataList: [Result]?
    var genreDict: [Result.MediaType:[Genre]] = [Result.MediaType.movie: [],
                                                 Result.MediaType.tv: []]
    
    var movieCastDict: [Int:[Cast]] = [:]
    var tvCastDict: [Int:[Cast]] = [:]
    
    let tableView = UITableView().then {
        $0.separatorInset = .zero
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        if dataList == nil {
            setWeeklyTrendData()
        }
        
        if genreDict[Result.MediaType.movie]?.count == 0 {
            setMovieGenreData()
        }
        
        if genreDict[Result.MediaType.tv]?.count == 0 {
            setTVGenreData()
        }
    
        configTableViewSetting()
        configHierarchy()
        configLayout()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
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
        getHTTPRequest(URL: TMDB.trendingAPIAllWeek.URL,
                       parameters: MyAuth.trendingParameters,
                       headers: MyAuth.headers,
                       decodingType: Trending.self,
                       callback: { (data: Trending) -> () in
                           self.dataList = data.results
                           self.setIdDict()
                           self.tableView.reloadData()
                        })
    }
    
    func setIdDict() {
        guard let dataList else {return}
        for result in dataList {
            switch result.mediaType {
            case .movie:
                movieCastDict[result.id] = []
            case .tv:
                tvCastDict[result.id] = []
            }
        }
    }
    
    func setMovieGenreData() {
        getHTTPRequest(URL: TMDB.genreAPIMovie.URL,
                       headers: MyAuth.headers,
                       decodingType: GenreList.self,
                       callback: {(data: GenreList) -> () in
                            self.genreDict[Result.MediaType.movie] = data.genres
                            self.tableView.reloadData()
                       })
    }
    
    func setTVGenreData() {
        getHTTPRequest(URL: TMDB.genreAPITV.URL,
                       headers: MyAuth.headers,
                       decodingType: GenreList.self,
                       callback: {(data: GenreList) -> () in
                           self.genreDict[Result.MediaType.tv] = data.genres
                           self.tableView.reloadData()
                       })
    }
    
    func setMovieCreditsData(id: Int) {
        let requestURL = TMDB.movieCreditsAPI.URL.replacingOccurrences(of: "{movie_id}", with: "\(id)")
        getHTTPRequest(URL: requestURL,
                       parameters: MyAuth.trendingParameters,
                       headers: MyAuth.headers,
                       decodingType: Credits.self,
                       callback: {(data: Credits) -> () in
                            self.movieCastDict[data.id] = data.cast
                            self.tableView.reloadData()
                       })
    }
    
    func setTVCreditsData(id: Int) {
        let requestURL = TMDB.tvSeriesCreditsAPI.URL.replacingOccurrences(of: "{series_id}", with: "\(id)")
        getHTTPRequest(URL: requestURL,
                       parameters: MyAuth.trendingParameters,
                       headers: MyAuth.headers,
                       decodingType: Credits.self,
                       callback: {(data: Credits) -> () in
                            self.tvCastDict[data.id] = data.cast
                            self.tableView.reloadData()
                       })
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
        
        // 최초 1회에 한해 Cast 데이터 request
        if data.mediaType == Result.MediaType.movie && movieCastDict[data.id]?.count == 0 {
            setMovieCreditsData(id: data.id)
        } else if data.mediaType == Result.MediaType.tv && tvCastDict[data.id]?.count == 0 {
            setTVCreditsData(id: data.id)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
                
        cell.configTrendingData(data)
        
        guard let genreList = genreDict[data.mediaType] else {return cell}
   
        var thisGenres: [Genre] = []
        var copyIDS = data.genreIDS
        
//        print(#function, genreDict)
        
        for genre in genreList {
            if copyIDS.count > 0, copyIDS.contains(genre.id) {
                thisGenres.append(genre)
                guard let idx = copyIDS.firstIndex(of: genre.id) else { return cell }
                copyIDS.remove(at: idx)
            }
        }
        
        cell.configGenreData(thisGenres)

        var cast: [Cast] = []
        switch data.mediaType {
        case .movie: cast = movieCastDict[data.id] ?? []
        case .tv: cast = tvCastDict[data.id] ?? []
        }
        
        cell.configCastData(data: cast)
       
    
        return cell
    }
}

