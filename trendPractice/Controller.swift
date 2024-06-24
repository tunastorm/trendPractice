//
//  ViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit

class Controller: UIViewController {
    
    var nextView: UIViewController.Type?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        switch nextView {
        case is MainViewController.Type:
            let vc = MainViewController()
            vc.delegate = self
            pushAfterView(view: vc, backButton: false, animated: false)
            
        case is SearchCollectionViewController.Type:
            let vc = SearchCollectionViewController()
            vc.delegate = self
            pushAfterView(view: vc, backButton: true, animated: false)
            
        default:
            let vc = MainViewController()
            vc.delegate = self
            pushAfterView(view: vc, backButton: false, animated: false)
        }
    }
}

