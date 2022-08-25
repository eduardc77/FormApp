//
//  DefaultFormButton.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/15/21.
//

import UIKit

class NextFormButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cornerRadius = 4
        setTitleColor(.lightGray, for: .normal)
        titleLabel?.textColor = UIColor(named: "primaryAction.text")
        tintColor = UIColor(named: "overlay.list")
        backgroundColor = UIColor(named: "primaryAction.background")
        setImage(UIImage(named: "chevron.right"), for: .normal)
        semanticContentAttribute = .forceRightToLeft
        imageEdgeInsets = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 0)
        
    }
}

class PreviousFormButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setTitleColor(.lightGray, for: .normal)
        cornerRadius = 4
        titleLabel?.textColor = UIColor(named: "category.text")
        tintColor = UIColor(named: "category.text")
        layer.borderColor = UIColor(named: "primaryAction.background")?.cgColor
        borderWidth = 1
        backgroundColor = UIColor(named: "background")
        setImage(UIImage(named: "chevron.left"), for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 8)
    }
}
