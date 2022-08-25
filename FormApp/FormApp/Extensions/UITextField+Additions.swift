//
//  UITextField+Additions.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/16/21.
//

import UIKit

extension UITextField {
    func addDoneButtonToolbar(onDone: (target: Any, action: Selector) = (target: self, action: #selector(doneButtonTapped))) {
        let toolbar: UIToolbar = UIToolbar(frame:CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: onDone.target, action: onDone.action)
        doneButton.tintColor = UIColor(named: "category.text")
        toolbar.items = [doneButton]
        
        self.inputAccessoryView = toolbar
    }
    
    //MARK: - Actions
    @objc func doneButtonTapped() { self.resignFirstResponder() }
}
