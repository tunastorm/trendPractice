//
//  DetailTableViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


class DetailTableViewCell: BaseTableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    

    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let horizontalCount = CGFloat(3)
        let verticalCount = CGFloat(4)
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
            $0.height.equalTo(190)
            $0.horizontalEdges.bottom.equalTo(contentView)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    override func configView() {
       self.backgroundColor = .clear
    }
    
    func configCell(mediaType: APIConstants.MediaType,rowIndex: Int) {
        let baseTitle = rowIndex == 0 ? UIResource.Text.detailViewSimilar.label : UIResource.Text.detailViewRecommand.label
        titleLabel.text = baseTitle + mediaType.kr
    }
}
