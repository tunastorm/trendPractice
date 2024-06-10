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
        $0.font = .systemFont(ofSize: UIResource.fontSize.thinest)
        $0.textAlignment = .left
        $0.textColor = .lightGray
    }
    
    let tagLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.thin)
        $0.textAlignment = .left
        $0.text = UIResource.Text.tag.sign
    }
    
    let videoView = RoundShadowView()
    
    let videoImageView = UIImageView().then {
        $0.contentMode = .scaleToFill
    }
    
    let bookmarkButton = UIButton().then{
        $0.backgroundColor = .white
        $0.setImage(UIResource.image.paperClip, for: .normal)
        $0.tintColor = .black
    }
    
    let rateTitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.backgroundColor = .systemPurple
    }
    
    let rateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: UIResource.fontSize.thin)
        $0.backgroundColor = .white
        
    }
    
    let videoTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: UIResource.fontSize.middle)
        $0.textAlignment = .left
    }
    
    let videoActerLabel = UILabel().then {
        $0.textAlignment = .left
        $0.font = .systemFont(ofSize: UIResource.fontSize.thinest)
        $0.textColor = .lightGray
    }
    
    let lineView = UIView().then {
        $0.backgroundColor = .black
    }
    
    let showDetailLabel = UILabel().then {
        $0.font = .systemFont(ofSize: UIResource.fontSize.thinest)
        $0.textAlignment = .left
    }
    
    let showDetailButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIResource.image.chevronRight, for: .normal)
    }

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // MarketTableViewCell의 contentView에 추가하는 코드
        configHierarchy()
        configLayout()
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(_ data: Result) {
        let baseURL = "https://image.tmdb.org/t/p/w780"
        let url = URL(string: baseURL+"/"+data.posterPath)
        videoView.containerView.kf.setImage(with: url)
    }

}

extension MainTableViewCell: CodeBaseUI {
    func configHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(videoView)
    }
    
    func configLayout() {
        dateLabel.snp.makeConstraints {
            $0.height.equalTo(12)
            $0.top.equalTo(contentView.safeAreaLayoutGuide).inset(20)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        tagLabel.snp.makeConstraints {
            $0.height.equalTo(14)
            $0.top.equalTo(dateLabel.snp.bottom).offset(4)
            $0.leading.equalTo(contentView.safeAreaLayoutGuide).inset(20)
        }
        videoView.snp.makeConstraints{
            $0.height.equalTo(300)
            $0.top.equalTo(tagLabel.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalToSuperview().inset(20)
        }
        
    }
    
    func configUI() {
     
    }
    
    
}
