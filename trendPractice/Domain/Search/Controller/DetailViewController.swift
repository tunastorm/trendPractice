//
//  DetailViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/24/24.
//

import UIKit


protocol DetailViewImage {
    var imagePath: String? { get }
}


class DetailViewController: BaseViewController {
   
    
    let rootView = DetailView()
    
    var mediaType: APIConstants.MediaType?
    var contentsId: Int?
    var contentsName: String?
    
    var responseList: [TMDBResponse] = [
        TMDBResponse(page: 1, totalPages: 1, totalResults: 0),
        TMDBResponse(page: 1, totalPages: 1, totalResults: 0)
    ]
    var imageVector: [[DetailViewImage]] = [[],[],[]]

    
    override func loadView() {
        view = rootView
    }

    override func viewDidLoad() {
        print(#function, imageVector.count)
        initialRequest()
        configNavigationbar(navigationColor: .black)
        configTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configNavigationbar(navigationColor: .black)
    }
    
    override func configNavigationbar(navigationColor: UIColor) {
        super.configNavigationbar(navigationColor: navigationColor)
        navigationItem.title = UIResource.Text.detailView.navigationTitle
    }
    
    
    private func configTableView() {
        rootView.tableView.delegate = self
        rootView.tableView.dataSource = self
        rootView.tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    func requestSimilar(idx: Int, page: Int) {
        guard let mediaType, let contentsId else {
            return
        }
        let router = APIRouter.similerAPI(contentsType: mediaType, contentsId: contentsId, page: page)
        APIClient.request(TMDBResponse.self, router: router) { similar, error in
            guard error == nil, let similar, let resultList = similar.results else {
                self.rootView.networkErrorEvent(error: error)
                return
            }
            print(#function, resultList)
            self.imageVector[idx].append(contentsOf: resultList)
            self.responseList[idx].page = similar.page
            let cell = self.rootView.tableView.cellForRow(at: [0,idx]) as! DetailTableViewCell
            cell.collectionView.reloadData()
        }
    }
    
    func requestRecommandations(idx: Int, page: Int) {
        guard let mediaType, let contentsId else {
            return
        }
        let router = APIRouter.recommendationsAPI(contentsType: mediaType, contentsId: contentsId, page: page)
        APIClient.request(TMDBResponse.self, router: router) { recommandations, error in
            guard error == nil, let recommandations, let resultList = recommandations.results else {
                self.rootView.networkErrorEvent(error: error)
                return
            }
            self.imageVector[idx].append(contentsOf: resultList)
            self.responseList[idx].page = recommandations.page
            let cell = self.rootView.tableView.cellForRow(at: [0,idx]) as! DetailTableViewCell
            cell.collectionView.reloadData()
        }
    }
    
    private func initialRequest() {
        guard let mediaType, let contentsId else {return}
        
        let group = DispatchGroup()
        let similar = APIRouter.similerAPI(contentsType: mediaType, contentsId: contentsId, page: 1)
        let recommandations = APIRouter.recommendationsAPI(contentsType: mediaType, contentsId: contentsId, page: 1)
        let images = APIRouter.imagesAPI(contentsType: mediaType, contentsId: contentsId, includeImageLanguage: APIConstants.includeImageLanguage)
        
        var succeesList: [Bool] = [false, false, false]
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIClient.request(TMDBResponse.self, router: similar) { similar, error in
                guard error == nil, let similar, let resultList = similar.results else {
                    self.rootView.networkErrorEvent(error: error)
                    group.leave()
                    return
                }
                self.imageVector[0] = resultList
                self.responseList[0] = similar
                self.responseList[0].results = nil
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIClient.request(TMDBResponse.self, router: recommandations){ recommandations, error in
                guard error == nil, let recommandations, let resultList = recommandations.results else {
                    self.rootView.networkErrorEvent(error: error)
                    group.leave()
                    return
                }
                self.imageVector[1] = resultList
                self.responseList[1] = recommandations
                self.responseList[1].results = nil
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group)  {
            APIClient.request(ImagesResponse.self, router: images) { images, error in
                guard error == nil, let images else {
                    self.rootView.networkErrorEvent(error: error)
                    group.leave()
                    return
                }
                self.imageVector[2] = images.posters
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.rootView.tableView.reloadData()
            self.imageVector.enumerated().forEach{ idx, imageList in
                if imageList.count <= 0 {
                    guard let cell = self.rootView.tableView.cellForRow(at: [0,idx]) else {
                        return
                    }
                    cell.isHidden = true
                }
            }
        }
    }
}
