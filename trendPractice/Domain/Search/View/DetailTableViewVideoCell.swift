//
//  DetailTableViewVideoCell.swift
//  trendPractice
//
//  Created by 유철원 on 7/1/24.
//

import UIKit

class DetailTableViewVideoCell: BaseTableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .white
        return view
    }()
   
    let videoLayout = {
        let layout = UICollectionViewFlowLayout()
        
        let horizontalCount = CGFloat(1)
        let verticalCount = CGFloat(2)
        let lineSpacing = CGFloat(10)
        let itemSpacing = CGFloat(5)
        let inset = CGFloat(10)
        
        let width: Double = UIScreen.main.bounds.width - 40.0
        let height: Double =  UIScreen.main.bounds.height - 90.0
        layout.itemSize = CGSize(width: width / horizontalCount, height: height / verticalCount)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        return layout
    }
//    
//    static func layout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        
//        let horizontalCount = CGFloat(2)
//        let verticalCount = CGFloat(4)
//        let lineSpacing = CGFloat(10)
//        let itemSpacing = CGFloat(5)
//        let inset = CGFloat(10)
//        
//        let width: Double = UIScreen.main.bounds.width - 40.0
//        let height: Double =  UIScreen.main.bounds.height - 90.0
//        layout.itemSize = CGSize(width: width / horizontalCount, height: height / verticalCount)
//        layout.scrollDirection = .horizontal
//        layout.minimumLineSpacing = lineSpacing
//        layout.minimumInteritemSpacing = itemSpacing
//        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
//        
//        return layout
//    }
    
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: videoLayout())
    
    override func configHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    override func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(260)
            $0.horizontalEdges.bottom.equalTo(contentView)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    override func configView() {
       self.backgroundColor = .clear
        collectionView.backgroundColor = .clear
    }
    
    func configCell(rowIdx: Int) {
        titleLabel.text = UIResource.Text.detailViewVideo.label
        print(#function, "videoCell configed")
    }
}


