//
//  DetailTableViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/25/24.
//

import UIKit


class DetailTableViewCell: UITableViewCell {
    
    let titleLabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 16)
        view.textColor = .black
        return view
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configHierarchy()
        configLayout()
        configView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func layout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0,
                                           left: 20,
                                           bottom: 0,
                                           right: 0)
        layout.scrollDirection = .horizontal
        return layout
    }
    func configHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
    }
    
    func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView).inset(20)
            $0.height.equalTo(20)
        }
        
        collectionView.snp.makeConstraints {
            $0.height.equalTo(180)
            $0.horizontalEdges.bottom.equalTo(contentView)
            $0.top.equalTo(titleLabel.snp.bottom)
        }
    }
    
    func configView() {
       self.backgroundColor = .clear
    }
    
    func configCell(contentsType: APIConstants.ContentsType,rowIndex: Int) {
      
        let baseTitle = rowIndex == 0 ? UIResource.Text.detailViewSimilar.label : UIResource.Text.detailViewRecommand.label
        titleLabel.text = baseTitle + String(describing: contentsType)
    }
}
