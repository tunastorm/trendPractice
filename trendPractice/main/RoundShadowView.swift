//
//  RoundShadowView.swift
//  trendPractice
//
//  Created by 유철원 on 6/11/24.
//

import UIKit
import SnapKit

class RoundShadowView: UIView {
  
    let containerView = UIImageView()
    private var radiousValue: CGFloat = UIResource.Number.mainViewVideoUIView.cornerRadious
    private var shadowLayer: CAShapeLayer!
    private var fillColor: UIColor = .lightGray //
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layoutView() {
      // set the shadow of the view's layer
      layer.backgroundColor = UIColor.clear.cgColor
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOffset = CGSize(width: 0, height: 1.0)
      layer.shadowOpacity = UIResource.opacity.quater
      layer.shadowRadius = UIResource.Number.mainViewVideoUIView.shadowCornerRadious
        
      // set the cornerRadius of the containerView's layer
      containerView.layer.cornerRadius = radiousValue
      containerView.layer.masksToBounds = true
      containerView.backgroundColor = .lightGray
    
    
      addSubview(containerView)
//      bringSubviewToFront(containerView)
      
      //
      // add additional views to the containerView here
      //
      
      // add constraints
      containerView.translatesAutoresizingMaskIntoConstraints = false
      
      // pin the containerView to the edges to the view
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
      containerView.topAnchor.constraint(equalTo: topAnchor).isActive = true
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    
    }
}
