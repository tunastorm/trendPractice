//
//  DetailViewCollectionViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit

import SnapKit
import Kingfisher


class DetailCollectionViewCell: BaseCollectionViewCell {
    
    var contentsType: APIConstants.MediaType?
    
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
    
    let imageView = UIImageView()
    
    
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
        imageView.layer.cornerRadius = radiousValue
        imageView.layer.masksToBounds = true
    }
    
    func configCell<T: Decodable>(data: T, contentsType: APIConstants.MediaType) {
        self.contentsType = contentsType

        let baseURL = UIResource.Text.imageBaseURL
        
        var url: URL?
        switch data {
        case is Result:
            let result = data as! Result
            guard let posterPath = result.posterPath else {
                return
            }
            url = URL(string: baseURL + posterPath)
        case is Poster:
            let poster = data as! Poster
            url = URL(string: baseURL + poster.path)
        default: return
        }
        guard let url else {return}
        imageView.kf.setImage(with: url)
    }
}
