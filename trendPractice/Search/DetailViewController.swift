//
//  DetailViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/24/24.
//

import UIKit


protocol DetailViewDelegate {
   
}


class DetailViewController: UIViewController {
   
    
    let detailView = DetailView()
    private let model = TMDBModel.shared
    
    var contentsType: APIConstants.ContentsType?
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
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.model.clearResponse(oldIndex: 0, responseType: Result.self)
            self.model.updateSimilar(contentsType: contentsType, contentsId: contentsId) { response in
                self.model.setNewResponse(oldIndex: 0, response: response)
                self.resultsList[0] = self.model.getSimilarResults()
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group) {
            self.model.clearResponse(oldIndex: 1, responseType: Result.self)
            self.model.updateRecommandations(contentsType: contentsType, contentsId: contentsId) { response in
                self.model.setNewResponse(oldIndex: 1, response: response)
                self.resultsList[1] = self.model.getRecommandationsResults()
                group.leave()
            }
        }
        
        group.enter()
        DispatchQueue.global().async(group: group)  {
            self.model.clearResponse(oldIndex: 0, responseType: ImagesResponse.self)
            self.model.updateImages(contentsType: contentsType, contentsId: contentsId) { response in
                self.model.setNewResponse(oldIndex: 0, response: response)
                self.imageList = self.model.getPosters()
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            self.detailView.tableView.reloadData()
        }
    }
}


extension DetailViewController: DetailViewDelegate {
        
}
