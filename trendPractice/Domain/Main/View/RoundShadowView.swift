//
//  RoundShadowView.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit
import SnapKit
import Then

class RoundShadowView: BaseView {
    
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
  
    let containerView = UIView()
    
    let imageView = UIImageView().then {
        $0.contentMode = .scaleToFill
        $0.layer.cornerRadius = UIResource.Number.mainViewVideoUIView.cornerRadious
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.layer.masksToBounds = true
    }
    
    let bookmarkButton = UIButton().then{
        $0.backgroundColor = .white
        $0.setImage(UIResource.image.paperClip, for: .normal)
        $0.tintColor = .black
    }
    
    let textView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let rateTitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.backgroundColor = .systemIndigo
        $0.textColor = .white
        $0.font = .boldSystemFont(ofSize: 14)
        $0.text = UIResource.Text.mainViewRate.label
    }
    
    let rateLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: UIResource.fontSize.thin)
        $0.backgroundColor = .white
    }
    
    let videoTitleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: UIResource.fontSize.middle)
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
        $0.font = .systemFont(ofSize: UIResource.fontSize.thin)
        $0.textAlignment = .left
        $0.text = UIResource.Text.mainViewShowDetail.label
    }
    
    let showDetailButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIResource.image.chevronRight, for: .normal)
    }
    
    override func configHierarchy() {
        addSubview(containerView)
        addSubview(imageView)
        addSubview(textView)
        addSubview(bookmarkButton)
        addSubview(rateTitleLabel)
        addSubview(rateLabel)
        addSubview(videoTitleLabel)
        addSubview(videoActerLabel)
        addSubview(lineView)
        addSubview(showDetailLabel)
        addSubview(showDetailButton)
    }
    
    override func configLayout() {
        containerView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.6)
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        bookmarkButton.snp.makeConstraints{
            $0.size.equalTo(30)
            $0.top.trailing.equalToSuperview().inset(16)
        }
        
        textView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.4)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
    
        rateTitleLabel.snp.makeConstraints {
            $0.height.equalTo(24)
            $0.width.equalTo(36)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalTo(textView.snp.top).offset(-16)
        }
        
        rateLabel.snp.makeConstraints {
            $0.height.equalTo(rateTitleLabel)
            $0.width.equalTo(48)
            $0.leading.equalTo(rateTitleLabel.snp.trailing)
            $0.bottom.equalTo(textView.snp.top).offset(-16)
        }
        
        videoTitleLabel.snp.makeConstraints { // 56
            $0.height.equalTo(40)
            $0.top.equalTo(textView.snp.top).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        videoActerLabel.snp.makeConstraints { //24
            $0.height.equalTo(20)
            $0.top.equalTo(videoTitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        lineView.snp.makeConstraints { //17
            $0.height.equalTo(1)
            $0.top.equalTo(videoActerLabel.snp.bottom).offset(16)
            $0.horizontalEdges.equalToSuperview().inset(16)
        }
        
        showDetailLabel.snp.makeConstraints { //35
            $0.height.equalTo(19)
            $0.top.equalTo(lineView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        showDetailButton.snp.makeConstraints { //
            $0.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    override func configView() {
        // set the shadow of the view's layer
        layer.backgroundColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = UIResource.opacity.quater
        layer.shadowRadius = UIResource.Number.mainViewVideoUIView.shadowCornerRadious
        
        // set the cornerRadius of the containerView's layer
        containerView.layer.cornerRadius = radiousValue
        containerView.layer.masksToBounds = true
        
        bookmarkButton.layer.masksToBounds = true
        bookmarkButton.layer.cornerRadius = 15
        
        textView.layer.masksToBounds = true
        textView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textView.layer.cornerRadius = radiousValue
    }
}
