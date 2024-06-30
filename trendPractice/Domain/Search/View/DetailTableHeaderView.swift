//
//  HeaderView.swift
//  trendPractice
//
//  Created by 유철원 on 6/30/24.
//

import UIKit

import SnapKit
import Then


class DetailTableHeaderView: BaseView {
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.textAlignment = .left
        $0.textColor = .white
    }
    
    override func configHierarchy() {
        self.addSubview(titleLabel)
    }
    
    override func configLayout() {
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.verticalEdges.equalToSuperview()
        }
    }
    
    override func configView() {
        self.backgroundColor = .black
    }
}
