//
//  SearchView.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import UIKit

import SnapKit
import Then


class SearchView: BaseView {
    
    let searchBar = UISearchBar().then {
        $0.searchBarStyle = .minimal
        $0.placeholder = UIResource.Text.searchCollectionView.placeHolder
    }
    
    lazy var collectionView = UICollectionView(frame: .zero,
                                          collectionViewLayout: collectionViewLayout())
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        
        let horizontalCount = CGFloat(3)
        let verticalCount = CGFloat(4)
        let lineSpacing = CGFloat(10)
        let itemSpacing = CGFloat(5)
        let inset = CGFloat(10)
        
        let width: Double = UIScreen.main.bounds.width - 40.0
        let height: Double =  UIScreen.main.bounds.height - 90.0
        layout.itemSize = CGSize(width: width / horizontalCount, height: height / verticalCount)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        
        return layout
    }
    
    override func configHierarchy() {
        self.addSubview(searchBar)
        self.addSubview(collectionView)
    }
    
    override func configLayout() {
        searchBar.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.top.equalTo(safeAreaLayoutGuide).inset(5)
            $0.horizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
        }
            
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(10)
            $0.bottom.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        super.configView()
        collectionView.backgroundColor = .clear
    }
    
    func networkErrorEvent(error: APIError?) {
        error?.showToast()
    }
    
}
