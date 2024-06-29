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
    private let model = TMDBModel.shared
    
    var mediaType: APIConstants.MediaType?
    var contentsId: Int?
    var contentsName: String?
    
    var imageVector: [[DetailViewImage]] = [[],[],[]]

    
    override func loadView() {
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function, imageVector.count)
        updateData()
        configTableView()
    }
    
    private func configTableView() {
        self.detailView.tableView.delegate = self
        self.detailView.tableView.dataSource = self
        self.detailView.tableView.prefetchDataSource = self
        self.detailView.tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.identifier)
    }
    
    private func updateData() {
        guard let mediaType, let contentsId else {return}
        
        let group = DispatchGroup()
        let similar = APIRouter.similerAPI(contentsType: mediaType, contentsId: contentsId, page: 1)
        let recommandations = APIRouter.recommendationsAPI(contentsType: mediaType, contentsId: contentsId, page: 1)
        let images = APIRouter.imagesAPI(contentsType: mediaType, contentsId: contentsId, includeImageLanguage: APIConstants.includeImageLanguage)
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIClient.request(TMDBResponse.self, router: similar) { similar, error in
                guard error == nil, let similar else {
                    print(#function, error)
                    group.leave()
                    return
                }
                self.imageVector[0] = similar.results?.filter{ media in
                    media.posterPath != nil
                } ?? []
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            APIClient.request(TMDBResponse.self, router: recommandations){ recommandations, error in
                guard error == nil, let recommandations else {
                    print(#function, error)
                    group.leave()
                    return
                }
                self.imageVector[1] = recommandations.results?.filter{ media in
                    media.posterPath != nil
                } ?? []
                self.imageVector[1]
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
                self.imageVector[2] = images.posters.filter{ media in
                    media.path != nil
                } ?? []
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            print(#function, self.imageVector)
            self.detailView.tableView.reloadData()
        }
    }
}
