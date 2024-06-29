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
    
    func configCell(data: DetailViewImage, contentsType: APIConstants.MediaType) {
        guard let imagePath = data.imagePath else {
            return
        }
        self.contentsType = contentsType
        let url = URL(string: UIResource.Text.imageBaseURL + imagePath)
        guard let url else {return}
        imageView.kf.setImage(with: url)
    }
}
