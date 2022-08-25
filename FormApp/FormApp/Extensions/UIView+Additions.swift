//
//  UIView+Additions.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/15/21.
//

import UIKit

extension UIView {
    func rotate(toValue value: CGFloat, duration: CFTimeInterval = 0.3) {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.toValue = value
        rotationAnimation.duration = duration
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = .forwards
        
        self.layer.add(rotationAnimation, forKey: nil)
    }
}
