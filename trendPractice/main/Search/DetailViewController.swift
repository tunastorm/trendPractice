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
   

    private let model = TMDBModel.shared
    let detailView = DetailView()
    
    var contentsType: APIConstants.ContentsType?
    var contentsId: Int?
    var contentsName: String?
    
    var similarItemSize = 0
    var recommandItemSize = 0

    override func loadView() {
        self.view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configDetailView()
        configCollectionView()
        requestSimilarAPI()
        requestRecommandationsAPI()
    }
    
    private func configDetailView() {
        self.detailView.delegate = self
        self.detailView.titleLabel.text = contentsName
        self.detailView.contentsType = contentsType
    }
    
    private func configCollectionView() {
        let similarCollectionView = self.detailView.similarCollectionView
        let recommandCollectionView = self.detailView.recommandCollectionView
        similarCollectionView.delegate = self
        similarCollectionView.dataSource = self
        similarCollectionView.prefetchDataSource = self
        similarCollectionView.register(DetailCollectionViewCell.self,
                                forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
        recommandCollectionView.delegate = self
        recommandCollectionView.dataSource = self
        recommandCollectionView.prefetchDataSource = self
        recommandCollectionView.register(DetailCollectionViewCell.self,
                                  forCellWithReuseIdentifier: DetailCollectionViewCell.identifier)
    }
    
    private func requestSimilarAPI() {
        guard let contentsType, let contentsId, let contentsName else {return}
        model.requestSimilarAPI(contentsType: contentsType, contentsId: contentsId) { results in
//            print(#function, contentsType, contentsId, contentsName)
            self.detailView.similarResults = results
            self.similarItemSize = results.count
        }
    }
    
    private func scrollSimilarAPI() {
        requestSimilarAPI()
    }
    
    private func requestRecommandationsAPI() {
        guard let contentsType, let contentsId, let contentsName else {return}
        model.requestRecommandationsAPI(contentsType: contentsType, contentsId: contentsId) { results in
            print(#function, contentsType, contentsId, contentsName)
            self.detailView.recommandResults = results
            self.recommandItemSize = results.count
        }
    }
}


