//
//  ViewTransition.swift
//  trendPractice
//
//  Created by 유철원 on 6/10/24.
//
import UIKit


protocol ViewTransitionDelegate {
   
    func pushAfterView(view: UIViewController, backButton: Bool, animated: Bool)
    
    func presentAfterView(view: UIViewController, presentationStyle: UIModalPresentationStyle, animated: Bool)
    
    func navigationPresentAfterView(view: UIViewController, style: UIModalPresentationStyle, animated: Bool)
    
    func popBeforeView(animated: Bool)
   
    func popToBeforeView(_ view: UIViewController, animated: Bool)
    
    func popToRootView(animated: Bool)
}

// 제네릭, 프로토콜
// some -> Opaque Type, any -> Existential Type
// WWDC

extension UIViewController: ViewTransitionDelegate {

    func pushAfterView(view: UIViewController, backButton: Bool, animated: Bool) {
        if !backButton {
            view.navigationItem.hidesBackButton = true
        }
        self.navigationController?.pushViewController(view, animated: animated)
    }
    
    func presentAfterView(view: UIViewController, presentationStyle: UIModalPresentationStyle, animated: Bool) {
        view.modalPresentationStyle = presentationStyle
        self.present(view, animated: animated)
    }
    
    func navigationPresentAfterView(view: UIViewController, style: UIModalPresentationStyle, animated: Bool) {
        let nav = UINavigationController(rootViewController: view)
        nav.modalPresentationStyle = style
        present(nav, animated: animated)
    }
    
    func popBeforeView(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToBeforeView(_ view: UIViewController, animated: Bool) {
        navigationController?.popToViewController(view, animated: animated)
    }
    
    func popToRootView(animated: Bool) {
        navigationController?.popToRootViewController(animated: true)
    }
}

protocol CellTransitionDelegate {
    func pushAfterViewType<T: UIViewController>(type: T.Type, backButton: Bool, animated: Bool, contents: (APIConstants.MediaType, Int, String) )
}



