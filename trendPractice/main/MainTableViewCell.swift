//
//  MainTableViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit

import Alamofire
import Kingfisher
import SnapKit
import Then


class MainTableViewCell: UITableViewCell {
    
    
    let dateLabel = UILabel().then {
        $0.font
    }
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MarketTableViewCell의 contentView에 추가하는 코드
        configHierarchy()
        configLayout()
        configUI()
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell() {
        
    }

}

extension MainTableViewCell: CodeBaseUI {
    func configHierarchy() {
        
    }
    
    func configLayout() {
        
    }
    
    func configUI() {
       
    }
    
    
}
