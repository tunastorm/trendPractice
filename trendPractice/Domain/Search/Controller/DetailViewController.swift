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


class DetailViewController: UIViewController {
   
    
    let detailView = DetailView()
    
    var mediaType: APIConstants.MediaType?
    var contentsId: Int?
    var contentsName: String?
    
    var responseList: [TMDBResponse] = [
        TMDBResponse(page: 1, totalPages: 1, totalResults: 0),
        TMDBResponse(page: 1, totalPages: 1, totalResults: 0)
    ]
    var imageVector: [[DetailViewImage]] = [[],[],[]]

    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, imageVector.count)
        initialRequest()
        configTableView()
    }
    
    private func configTableView() {
        detailView.tableView.delegate = self
        detailView.tableView.dataSource = self
        detailView.tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    func requestSimilar(idx: Int, page: Int) {
        guard let mediaType, let contentsId else {
            return
        }
        let router = APIRouter.similerAPI(contentsType: mediaType, contentsId: contentsId, page: page)
        APIClient.request(TMDBResponse.self, router: router) { similar, error in
            guard error == nil, let similar, let resultList = similar.results else {
                return
            }
            self.imageVector[idx].append(contentsOf: resultList)
            self.responseList[idx].page = similar.page
            let cell = self.detailView.tableView.cellForRow(at: [0,idx]) as! DetailTableViewCell
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
                return
            }
            self.imageVector[idx].append(contentsOf: resultList)
            self.responseList[idx].page = recommandations.page
            let cell = self.detailView.tableView.cellForRow(at: [0,idx]) as! DetailTableViewCell
            cell.collectionView.reloadData()
        }
    }
    
    private func initialRequest() {
        guard let mediaType, let contentsId else {return}
        
        let group = DispatchGroup()
        let similar = APIRouter.similerAPI(contentsType: mediaType, contentsId: contentsId, page: 1)
        let recommandations = APIRouter.recommendationsAPI(contentsType: mediaType, contentsId: contentsId, page: 1)
        let images = APIRouter.imagesAPI(contentsType: mediaType, contentsId: contentsId, includeImageLanguage: APIConstants.includeImageLanguage)
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIClient.request(TMDBResponse.self, router: similar) { similar, error in
                guard error == nil, let similar, let resultList = similar.results else {
                    print(#function, error)
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
                    print(#function, error)
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
                    print(#function, error)
                    group.leave()
                    return
                }
                self.imageVector[2] = images.posters
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print(#function, self.imageVector)
            self.detailView.tableView.reloadData()
        }
    }
}
