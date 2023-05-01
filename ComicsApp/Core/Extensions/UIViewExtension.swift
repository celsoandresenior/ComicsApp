//
//  UIViewExtension.swift
//  ComicsApp
//
//  Created by Celso Lima on 27/04/23.
//

import UIKit

extension UIView {
    func animateButtonPress(){
           UIView.animate(withDuration: 0.2,
              animations: {
               self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
           },
              completion: { _ in
               UIView.animate(withDuration: 0.2) {
                   self.transform = CGAffineTransform.identity
               }
           })
    }
    
    func applyShadow(shadowColour: UIColor){
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.63
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 3, height: 2)
        self.layer.shadowColor = shadowColour.cgColor
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
