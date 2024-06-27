//
//  SearchMediaCollectionViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

class SearchMediaCollectionViewCell: UICollectionViewCell {
    
    var delegate: CellTransitionDelegate?
    
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
    
    let shadowView = UIView()
    let imageView = UIImageView()
    var contentsType: APIConstants.MediaType?
    var contentsName: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("warning!!!!!!!!!!!!!")
    }
    
    func configCell(_ data: Result, type: APIConstants.MediaType) {
        print(#function, type)
        self.contentsType = type
        self.contentsName = data.title
        let baseURL = "https://image.tmdb.org/t/p/w780"
        let url = URL(string: baseURL + data.posterPath)
        imageView.kf.setImage(with: url)
        shadowView.tag = data.id
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(goDetailView))
        shadowView.addGestureRecognizer(tapGesture)
    }
    
    @objc func goDetailView() {
        guard let contentsType, let contentsName else {return}
        print(#function, " \(contentsType) | \(shadowView.tag) | \(contentsName)")
        delegate?.pushAfterViewType(type: DetailViewController.self, backButton: true, animated: true,
                                    contents: (contentsType, shadowView.tag, contentsName))
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

        imageView.layer.cornerRadius = radiousValue
        imageView.layer.masksToBounds = true
    }
}
