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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationbar(navigationColor: .white)
    }
    
    func configNavigationbar(navigationColor: UIColor) {
        navigationItem.backButtonTitle = ""
        
        let textAttributes = navigationColor == .black ?
        [NSAttributedString.Key.foregroundColor: UIColor.white] : [NSAttributedString.Key.foregroundColor: UIColor.black]
       
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = navigationColor
        appearance.shadowImage = nil
        appearance.titleTextAttributes = textAttributes
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        switch navigationColor {
        case .white: self.navigationController?.navigationBar.tintColor = .black
        case .black: self.navigationController?.navigationBar.tintColor = .white
        default:  self.navigationController?.navigationBar.tintColor = .black
        }
    }
}
