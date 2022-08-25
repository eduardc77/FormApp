//
//  Checkbox.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/15/21.
//

import UIKit

class Checkbox: UIButton {
    override var isSelected: Bool {
        didSet {
            let settingsColor = UIColor(named: "settings.background.icon")
            backgroundColor = isSelected ? settingsColor : UIColor(named: "background")
            
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.setImage(UIImage(named: "checkmark"), for: .selected)
        self.setImage(nil, for: .normal)
    }
}
