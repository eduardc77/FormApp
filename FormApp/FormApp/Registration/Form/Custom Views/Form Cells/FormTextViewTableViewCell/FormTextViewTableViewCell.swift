//
//  FormTextViewTableViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

class FormTextViewTableViewCell: UITableViewCell, FormConformity {
    //MARK: - Outlets
    
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Properties
    
    var pageItem: PageItem?
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}

// MARK: - FormUpdatable

extension FormTextViewTableViewCell: FormUpdatable {
    func update(with pageItem: PageItem) {
        self.pageItem = pageItem
        
        textView.text = self.pageItem?.value
    }
}

//MARK: - Private Methods

private extension FormTextViewTableViewCell {
    @objc func textFieldDidChanged(_ textField: UITextField) {
        self.pageItem?.valueCompletion?(textField.text)
    }
}
