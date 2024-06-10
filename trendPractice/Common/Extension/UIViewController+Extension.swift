//
//  UIViewController+Extension.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit


extension UIViewController {
    
    func setDefaultUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowImage = nil
        appearance.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}

