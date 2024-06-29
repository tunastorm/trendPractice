//
//  DetailView.swift
//  trendPractice
//
//  Created by 유철원 on 6/27/24.
//

import UIKit

import SnapKit
import Then


class MainDetailView: BaseView {
    
    let titleView = UIImageView()
    
    let titleCoverView = UIView().then {
        $0.backgroundColor = . black
        $0.layer.opacity = 0.3
    }

    let overView = UIView()

    let posterView = UIImageView()
    
    let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 24, weight: .heavy)
        $0.textColor = .white
    }
    
    let overViewLabel = UILabel().then {
        $0.text = "OverView"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let overViewContentsLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.numberOfLines = 2
    }
    
    let overViewButton = UIButton().then {
        $0.tintColor = .black
        $0.setImage(UIResource.image.chevronDown, for: .normal)
        $0.addTarget(self, action: #selector(overViewButtonClicked), for: .touchUpInside)
    }
    
    let underlineView = UIView().then {
        $0.backgroundColor = .systemGray5
    }
    
    let castTitleLabel = UILabel().then {
        $0.text = "Cast"
        $0.font = .boldSystemFont(ofSize: 14)
        $0.textColor = .gray
    }
    
    let tableView = UITableView().then {
        $0.separatorInset = .zero
        $0.separatorStyle = .singleLine
    }

    override func configHierarchy() {
        self.addSubview(titleView)
        titleView.addSubview(titleCoverView)
        titleView.addSubview(titleLabel)
        titleView.addSubview(posterView)
        self.addSubview(overView)
        overView.addSubview(overViewLabel)
        overView.addSubview(overViewContentsLabel)
        overView.addSubview(overViewButton)
        self.addSubview(underlineView)
        self.addSubview(castTitleLabel)
        self.addSubview(tableView)
    }
    
    override func configLayout() {
        let height = UIScreen.main.bounds.height
        titleView.snp.makeConstraints {
            $0.height.equalTo(height * 0.26)
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
        
        titleCoverView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.horizontalEdges.equalToSuperview().inset(20)
        }
        
        posterView.snp.makeConstraints {
            $0.width.equalTo(100)
            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(10)
        }
        
        overView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(height * 0.14)
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        overViewLabel.snp.makeConstraints {
            $0.height.equalTo(30)
            $0.top.horizontalEdges.equalToSuperview()
        }
        
        overViewContentsLabel.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(40)
            $0.top.equalTo(overViewLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        overViewButton.snp.makeConstraints {
            $0.size.equalTo(30)
            $0.top.equalTo(overViewContentsLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
        
        underlineView.snp.makeConstraints {
            $0.height.equalTo(1)
            $0.top.equalTo(overView.snp.bottom)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        castTitleLabel.snp.makeConstraints {
            $0.height.equalTo(20)
            $0.top.equalTo(underlineView.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(20)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(castTitleLabel.snp.bottom)
            $0.trailing.equalTo(safeAreaLayoutGuide)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configView() {
        self.backgroundColor = .white
        self.tableView.rowHeight = 86
    }
        
    override func setNeedsLayout() {
        super.setNeedsLayout()
        overViewLabel.layer.addBorder([.bottom], color: .systemGray5, width: 1)
        tableView.layer.addBorder([.top], color: .systemGray5, width: 1)
    }
    
    @objc func overViewButtonClicked(_ sender: UIButton) {
        if overViewContentsLabel.numberOfLines == 2 {
            overViewContentsLabel.numberOfLines = 0
            sender.setImage(UIResource.image.chevronUp, for: .normal)
        } else {
            overViewContentsLabel.numberOfLines = 2
            sender.setImage(UIResource.image.chevronDown, for: .normal)
        }
    }
    
    
}
