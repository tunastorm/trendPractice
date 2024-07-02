//
//  DetailCollectionViewVideoCell.swift
//  trendPractice
//
//  Created by 유철원 on 7/1/24.
//

import UIKit
import WebKit

import SnapKit


class DetailCollectionViewVideoCell: BaseCollectionViewCell {
    
    var mediaType: APIConstants.MediaType?
    
    let webView = WKWebView()
    
    override func configHierarchy() {
        contentView.addSubview(webView)
    }
    
    override func configLayout() {
        webView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    override func configView() {
        self.backgroundColor = .clear
        webView.backgroundColor = .darkGray
    }
    
    func configCell(data: DetailViewImage, mediaType: APIConstants.MediaType) {
        guard let imagePath = data.imagePath, let url = URL(string: TMDB.youTubeBaseURL + imagePath) else {
            print(#function, "cell config 실패")
            return
        }
        print(#function, url)
        self.mediaType = mediaType
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
