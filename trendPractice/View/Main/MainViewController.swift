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
    
    let model = TMDBModel.shared

    var dataList: [Result]?
    
    var genreDict: [APIConstants.MediaType : [Genre]] = [.movie: [], .tv: []]
    var castDict: [APIConstants.MediaType : [Int:[Cast]]] = [.movie: [:], .tv: [:]]

    let tableView = UITableView().then {
        $0.separatorInset = .zero
        $0.separatorStyle = .none
    }
    
    let searchVC = SearchCollectionViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setData()
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
    
    func setData() {
        let group = DispatchGroup()
        let trending = APIRouter.trendingAPI(contentsType: .all, timeWindow: .week)
        let movieGenre = APIRouter.genreAPI(contentsType: .movie)
        let tvGenre = APIRouter.genreAPI(contentsType: .tv)
        
        group.enter()
        model.requestTMDB(responseType: TMDBResponse.self, router: trending) { trending, error in
            guard error == nil, let trending else {
                print(#function, error)
                group.leave()
                return
            }
            self.dataList = trending.results
            self.dataList?.forEach {
                if $0.mediaType == .movie {
                    print($0.title)
                } else {
                    print($0.name)
                }
                
            }
         
            group.leave()
        }
        group.enter()
        model.requestTMDB(responseType: GenreResponse.self, router: movieGenre) { movieGenre, error in
            guard error == nil, let movieGenre else {
                print(#function, error)
                group.leave()
                return
            }
            self.genreDict[.movie] = movieGenre.genres
            print(#function, self.genreDict)
            group.leave()
        }
        group.enter()
        model.requestTMDB(responseType: GenreResponse.self, router: tvGenre) { tvGenre, error in
            guard error == nil, let tvGenre else {
                print(#function, error)
                group.leave()
                return
            }
            self.genreDict[.tv] = tvGenre.genres
            print(#function, self.genreDict)
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.tableView.reloadData()
        }
    }
    
    func setCreditsData(contentsType: APIConstants.MediaType, contentsId: Int, indexPath: IndexPath) {
        let router = APIRouter.creditsAPI(contentsType: contentsType, contentsId: contentsId)
        model.requestTMDB(responseType: Credits.self, router: router) { credits, error in
            guard error == nil, let credits else {
                print(#function, error)
                return
            }
            self.castDict[contentsType]?[credits.id] = credits.cast
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
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
        setDefaultUI()
        let barButtonItem = UIBarButtonItem(image: UIResource.image.magnifyingGlass,
                                            style: .plain, target: self, action:#selector(goSearchPage))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func goSearchPage() {
        pushAfterView(view: searchVC, backButton: true, animated: true)
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
        
        print(#function, indexPath.row, data.title, data.name)
        
        // 최초 1회에 한해 Cast 데이터 request
        if castDict[data.mediaType]?[data.id] == nil {
            setCreditsData(contentsType: data.mediaType, contentsId: data.id, indexPath: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
                
        cell.configTrendingData(data)
        
        guard let genreList = genreDict[data.mediaType] else {return cell}
   
        var thisGenres: [Genre] = []
        var copyIDS = data.genreIDS
        
        for genre in genreList {
            if copyIDS.count > 0, copyIDS.contains(genre.id) {
                thisGenres.append(genre)
                guard let idx = copyIDS.firstIndex(of: genre.id) else { return cell }
                copyIDS.remove(at: idx)
            }
        }
        
        cell.configGenreData(thisGenres)

        guard let cast = castDict[data.mediaType]?[data.id] else {
            return cell
        }
        
        cell.configCastData(data: cast)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let dataList else {
            return
        }
        let data = dataList[indexPath.row]
        print(#function, data.title)
        let mainDetailVC = MainDetailViewController()
        mainDetailVC.data = data
        pushAfterView(view: mainDetailVC, backButton: true, animated: true)
    }
}

