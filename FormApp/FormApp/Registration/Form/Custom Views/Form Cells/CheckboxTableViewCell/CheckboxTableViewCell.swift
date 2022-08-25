//
//  CheckboxTableViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

class CheckboxTableViewCell: UITableViewCell, FormConformity, CellUpdatable {
    //MARK: - Outlets
    
    @IBOutlet weak var checkboxView: UIView!
    @IBOutlet weak var checkboxButton: Checkbox!
    @IBOutlet weak var termsAndConditionsTextView: UITextView!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    
    var pageItem: PageItem?
    weak var cellUpdaterDelegate: CustomCellUpdater?
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkboxTapped))
        checkboxView.addGestureRecognizer(tapGesture)
    }
}

// MARK: - FormUpdatable

extension CheckboxTableViewCell: FormUpdatable {
    func update(with pageItem: PageItem) {
        setupTermsAndConditionsText()
        self.pageItem = pageItem
        
        //UI properties
        checkboxButton.layer.borderColor = self.pageItem?.uiProperties.borderColor
        checkboxButton.layer.borderWidth = self.pageItem?.uiProperties.borderWidth ?? 1
        
        checkItemValidity()
        self.pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
}

//MARK: - Private Methods

private extension CheckboxTableViewCell {
    /// Checks if the item value is valid.
    func checkItemValidity() {
        guard let pageItem = pageItem else { return }
        
        if checkboxButton.isSelected {
            pageItem.valueCompletion?("True")
        } else {
            pageItem.valueCompletion?(nil)
        }
        
        pageItem.checkValidity()
    }
    
    /// Updates the border color and error message.
    func updateUIProperties() {
        self.pageItem?.updateUIProperties(for: checkboxButton)
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
    
    //TODO: - Change this to return the right language text.
    func setupTermsAndConditionsText() {
        guard let url = URL(string: "https://www.lipsum.com"), UIApplication.shared.canOpenURL(url) else { return }
        
        let attributedText = NSMutableAttributedString(string: "I have read and accept the terms and conditions.", attributes: [.font: UIFont.preferredFont(forTextStyle: .callout),
                                                                                                                                                                 .foregroundColor : UIColor(named: "textColor") as Any])
        attributedText.setAttributes([
            .link: url,
            .font: UIFont.preferredFont(forTextStyle: .headline),
        ], range: NSMakeRange(27, 20))
        
        termsAndConditionsTextView.attributedText = attributedText
        termsAndConditionsTextView.linkTextAttributes = [
            .foregroundColor : UIColor(named: "category.text") as Any,
            .underlineStyle : NSUnderlineStyle.single.rawValue,
        ]
    }
    
    @objc func checkboxTapped() {
        checkboxButton.isSelected.toggle()
        
        checkItemValidity()
        updateUIProperties()
    }
}
