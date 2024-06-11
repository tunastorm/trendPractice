//
//  SearchMediaCollectionViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

class SearchMediaCollectionViewCell: UICollectionViewCell {
    
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
    
    let shadowView = UIView()
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
        contentView.addSubview(shadowView)
        shadowView.addSubview(imageView)
    }
    
    func configLayout() {
        shadowView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    
    func configUI() {
        shadowView.layer.backgroundColor = UIColor.clear.cgColor
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        shadowView.layer.shadowOpacity = 0.1
        shadowView.layer.shadowRadius = UIResource.Number.mainViewVideoUIView.shadowCornerRadious
//        layer.shadowPath = UIBezier
        
        // set the cornerRadius of the containerView's layer
        imageView.layer.cornerRadius = radiousValue
        imageView.layer.masksToBounds = true
    }
}
