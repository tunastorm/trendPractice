//
//  ViewController.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//

import UIKit

class Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultUI()
//        pushAfterView(view: MainViewController(), backButton: false, animated: false)
        pushAfterView(view: SearchCollectionViewController(), backButton: true, animated: true)

    }
    
    
    
    
}

