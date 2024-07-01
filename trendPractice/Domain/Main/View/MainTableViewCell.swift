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


class MainTableViewCell: BaseTableViewCell {
    
    
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
    
    override func configHierarchy() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(tagLabel)
        contentView.addSubview(videoView)
    }
    
    override func configLayout() {
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
            $0.height.equalTo(340)
            $0.top.equalTo(tagLabel.snp.bottom).offset(8)
            $0.bottom.horizontalEdges.equalToSuperview().inset(20)
        }
    }
    
    override func configView() {
        self.selectionStyle = .none
    }

    func configTrendingData(_ data: Result) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let oldDate = dateFormatter.date(from: data.getReleasDate()) else {return}
        
        dateFormatter.dateFormat = UIResource.Text.mainViewDate.dateFormatString
        
        dateLabel.text = dateFormatter.string(from: oldDate)
        
        videoView.rateLabel.text = String(format: "%.1f", data.voteAverage/2)
        videoView.videoTitleLabel.text = data.geTitle()
        
        guard let posterPath = data.posterPath else {
            return
        }
        let url = URL(string: UIResource.Text.imageBaseURL + posterPath)
        videoView.imageView.kf.setImage(with: url)
    }
    
    func configGenreData(_ data: [Genre]) {
        guard let tag = tagLabel.text else {return}
        
        if tag.count > 1 {
            return
        }
        
        var copyTag = tag
        for (idx, genre) in data.enumerated() {
            copyTag += genre.name
            if idx < data.count-1 {
                copyTag += ", #"
            }
        }
        tagLabel.text = copyTag
    }
    
    func configCastData(data: [Cast]) {
        var castText = ""
        for (idx,cast) in data.enumerated() {
            castText += cast.name
            if idx < data.count-1 {
                castText += ", "
            }
        }
        videoView.videoActerLabel.text = castText
    }
}
