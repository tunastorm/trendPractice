//
//  SearchMediaCollectionViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

class SearchCollectionViewCell: BaseCollectionViewCell {
    
    var delegate: CellTransitionDelegate?
    
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
    
    let imageView = UIImageView().then {
        $0.backgroundColor = .systemGray5
    }
    
    var contentsType: APIConstants.MediaType?
    var contentsName: String?
    
    
    override func configHierarchy() {
        contentView.addSubview(imageView)
    }
    
    override func configLayout() {
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    override func configView() {
        self.backgroundColor = .clear
        imageView.backgroundColor = .darkGray
        imageView.layer.cornerRadius = radiousValue
        imageView.layer.masksToBounds = true
    }
    
    func configCell(_ data: Result) {
        self.contentsType = data.mediaType
        self.contentsName = data.geTitle()
        
        if let posterPath = data.posterPath {
            let url = URL(string: UIResource.Text.imageBaseURL + posterPath)
            imageView.kf.setImage(with: url)
        }
        
        imageView.tag = data.id
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goDetailView))
        imageView.addGestureRecognizer(tapGesture)
    }
    
    @objc func goDetailView() {
        guard let contentsType, let contentsName else {return}
        print(#function, " \(contentsType) | \(imageView.tag) | \(contentsName)")
        delegate?.pushAfterViewType(type: DetailViewController.self, backButton: true, animated: true,
                                    contents: (contentsType, imageView.tag, contentsName))
    }
}
