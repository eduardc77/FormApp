//
//  DropDownField.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/17/21.
//

import UIKit

@IBDesignable
class DropDownField: UITextField {
    
    override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.rightViewRect(forBounds: bounds)
        textRect.origin.x -= rightPadding
        return textRect
    }
    
    @IBInspectable var rightImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var rightPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = .clear {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = rightImage {
            rightViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
            imageView.image = image
            imageView.tintColor = color
            rightView = imageView
        } else {
            rightViewMode = .never
            rightView = nil
        }
    }
}
