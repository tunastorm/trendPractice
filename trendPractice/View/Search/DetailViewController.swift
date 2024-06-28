//
//  DetailViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/24/24.
//

import UIKit



class DetailViewController: UIViewController {
   
    
    let detailView = DetailView()
    private let model = TMDBModel.shared
    
    var contentsType: APIConstants.MediaType?
    var contentsId: Int?
    var contentsName: String?
    
    var resultsList: [[Result]] = [[],[]]
    var imageList: [Poster] = []
    
    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        updateData()
    }
    
    func configTableView() {
        self.detailView.tableView.delegate = self
        self.detailView.tableView.dataSource = self
        self.detailView.tableView.prefetchDataSource = self
        self.detailView.tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    private func updateData() {
        guard let contentsType, let contentsId else {return}
        
        let group = DispatchGroup()
        let similar = APIRouter.similerAPI(contentsType: contentsType, contentsId: contentsId, page: 1)
        let recommandations = APIRouter.recommendationsAPI(contentsType: contentsType, contentsId: contentsId, page: 1)
        let images = APIRouter.imagesAPI(contentsType: contentsType, contentsId: contentsId, includeImageLanguage: APIConstants.includeImageLanguage)
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            
            self.model.clearResponse(oldIndex: 0, responseType: Result.self)
            self.model.requestTMDB(responseType: TMDBResponse.self, router: similar) { similar, error in
                
                guard error == nil, let similar else {
                    print(#function, error)
                    group.leave()
                    return
                }
                self.model.setNewResponse(oldIndex: 0, response: similar)
                self.resultsList[0] = self.model.getSimilarResults()
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.model.clearResponse(oldIndex: 1, responseType: Result.self)
            self.model.requestTMDB(responseType: TMDBResponse.self, router: recommandations){ recommandations, error in
                
                guard error == nil, let recommandations else {
                    print(#function, error)
                    group.leave()
                    return
                }
                
                self.model.setNewResponse(oldIndex: 1, response: recommandations)
                self.resultsList[1] = self.model.getRecommandationsResults()
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group)  {
            self.model.clearResponse(oldIndex: 0, responseType: ImagesResponse.self)
            self.model.requestTMDB(responseType: ImagesResponse.self, router: images) { images, error in
                
                guard error == nil, let images else {
                    print(#function, error)
                    group.leave()
                    return
                }
            
                self.model.setNewResponse(oldIndex: 0, response: images)
                self.imageList = self.model.getPosters()
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.detailView.tableView.reloadData()
        }
    }
}
