//
//  BaseViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/29/24.
//

import UIKit


class BaseViewController: UIViewController {
    
    override func loadView() {
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationbar()
    }
    
    func configNavigationbar() {
        self.navigationController?.navigationBar.tintColor = .black
        
        navigationItem.backButtonTitle = ""
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.shadowImage = nil
        appearance.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
}
