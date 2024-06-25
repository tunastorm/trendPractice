//
//  DetailViewCollectionViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit

import SnapKit
import Kingfisher


class DetailCollectionViewCell: UICollectionViewCell {
    
    var contentsType: APIConstants.ContentsType?
    
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
        fatalError("init(coder:) has not been implemented")
    }
    
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

        imageView.layer.cornerRadius = radiousValue
        imageView.layer.masksToBounds = true
    }
    
    func configCell<T: Decodable>(data: T, contentsType: APIConstants.ContentsType) {
        self.contentsType = contentsType

        let baseURL = UIResource.Text.imageBaseURL
        
        var url: URL?
        switch data {
        case is Result:
            let result = data as! Result
            url = URL(string: baseURL + result.posterPath)
        case is Poster:
            let poster = data as! Poster
            url = URL(string: baseURL + poster.path)
        default: return
        }
        guard let url else {return}
        imageView.kf.setImage(with: url)
    }
}
