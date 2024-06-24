//
//  DetailView.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit

import SnapKit
import Then

class DetailView: UIView {

    var delegate: DetailViewDelegate?
    
    var titleLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: 30)
        $0.textColor = .black
    }
    
    private var similarLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.thick)
        $0.textColor = .black
//        $0.text = "추천 영화"
    }
    
    private var recommandLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.thick)
        $0.textColor = .black
//        $0.text = "추천 TV 시리즈"
    }
    
    lazy var similarCollectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionViewLayout())
    
    lazy var recommandCollectionView = UICollectionView(frame: .zero,
                                                 collectionViewLayout: collectionViewLayout())
    
    var contentsType: APIConstants.ContentsType?
    
    var similarResults: [Result] = [] {
        didSet {
//            print(#function, similarResults)
            labelTitleToggle()
            self.similarCollectionView.reloadData()
        }
    }
    
    var recommandResults: [Result] = [] {
        didSet {
            labelTitleToggle()
            self.recommandCollectionView.reloadData()
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
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
    

    private func configHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(similarLabel)
        self.addSubview(similarCollectionView)
        self.addSubview(recommandLabel)
        self.addSubview(recommandCollectionView)
    }
    
    private func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        similarLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        similarCollectionView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.equalTo(similarLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
        
        recommandLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(similarCollectionView.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
        }
        
        recommandCollectionView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.top.equalTo(recommandLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
    private func configUI() {
        self.backgroundColor = .white
        labelTitleToggle()
    }
    
    private func labelTitleToggle() {
        guard let contentsType else {return}
        switch contentsType {
        case .movie:
            similarLabel.text = UIResource.Text.detailViewSimilar.label + "영화"
            recommandLabel.text = UIResource.Text.detailViewRecommand.label + "영화"
        case .tv:
            similarLabel.text = UIResource.Text.detailViewSimilar.label + "TV 시리즈"
            recommandLabel.text = UIResource.Text.detailViewRecommand.label + "TV 시리즈"
        }
    }
}
