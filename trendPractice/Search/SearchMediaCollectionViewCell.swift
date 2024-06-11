//
//  SearchMediaCollectionViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

class SearchMediaCollectionViewCell: UICollectionViewCell {
    
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
    
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("warning!!!!!!!!!!!!!")
    }
    
    func configCell(_ data: Result) {
        let baseURL = "https://image.tmdb.org/t/p/w780"
        let url = URL(string: baseURL + data.posterPath)
        imageView.kf.setImage(with: url)
    }
}

extension SearchMediaCollectionViewCell: CodeBaseUI {
    func configHierarchy() {
        contentView.addSubview(imageView)
    }
    
    func configLayout() {
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func configUI() {
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.1)
        layer.shadowOpacity = UIResource.opacity.quater
        layer.shadowRadius = UIResource.Number.mainViewVideoUIView.shadowCornerRadious
        
        // set the cornerRadius of the containerView's layer
        imageView.layer.cornerRadius = radiousValue
        imageView.layer.masksToBounds = true
    }
}
