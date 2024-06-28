//
//  MainDetailTableViewCell.swift
//  trendPractice
//
//  Created by 유철원 on 6/27/24.
//

import UIKit

import Kingfisher
import SnapKit
import Then


class MainDetailTableViewCell: BaseTableViewCell {
    
    let profileImage = UIImageView().then {
        $0.backgroundColor = .systemGray4
        $0.image = UIResource.image.person
        $0.tintColor = .white
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 5
        $0.maskToBound = true
    }
    
    let labelView = UIView()
    
    let actorLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 18)
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    let characterLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .systemGray4
        $0.textAlignment = .left
    }
    
    
    override func configHierarchy() {
        contentView.addSubview(profileImage)
        contentView.addSubview(labelView)
        labelView.addSubview(actorLabel)
        labelView.addSubview(characterLabel)
    }
    
    override func configLayout() {
        profileImage.snp.makeConstraints {
            $0.height.equalTo(80)
            $0.width.equalTo(50)
            $0.verticalEdges.equalToSuperview().inset(10)
            $0.leading.equalToSuperview()
        }
        
        labelView.snp.makeConstraints {
            $0.height.equalTo(40)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        actorLabel.snp.makeConstraints {
            $0.height.equalTo(18)
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        characterLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(actorLabel.snp.bottom).offset(6)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    }

    override func configView() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
    }
    
    func configCell(data: Cast) {
        guard let profilePath = data.profilePath, let profile = URL(string: UIResource.Text.imageBaseURL + profilePath) else {
            return
        }
        profileImage.kf.setImage(with: profile)
        actorLabel.text = data.name
        characterLabel.text = data.character
    }
}
