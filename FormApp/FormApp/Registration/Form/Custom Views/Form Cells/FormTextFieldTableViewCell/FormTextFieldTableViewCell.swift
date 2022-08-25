//
//  FormTextFieldTableViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

class FormTextFieldTableViewCell: UITableViewCell, FormConformity, CellUpdatable {
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var formTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var cellButton: UIButton!
    
    //MARK: - Properties
    
    var pageItem: PageItem?
    var isSendButtonHidden: Bool?
    weak var cellButtonDelegate: CellButtonDelegate?
    weak var cellUpdaterDelegate: CustomCellUpdater?
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        formTextField.delegate = self
        formTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        formTextField.addTarget(self, action: #selector(textFieldTapped(_:)), for: .editingDidBegin)   
    }
    
    //MARK: - Actions
    
    @IBAction func cellButtonTapped(_ sender: UIButton) {
        cellButtonDelegate?.cellButtonTapped()
    }
}

// MARK: - FormUpdatable

extension FormTextFieldTableViewCell: FormUpdatable {
    func update(with pageItem: PageItem) {
        self.pageItem = pageItem
        toggleCellButtonHidden()
        
        titleLabel.text = self.pageItem?.title
        formTextField.text = self.pageItem?.value
        formTextField.placeholder = self.pageItem?.placeholder
        
        //UI properties
        formTextField.layer.borderColor = self.pageItem?.uiProperties.borderColor
        formTextField.layer.borderWidth = self.pageItem?.uiProperties.borderWidth ?? 1
        formTextField.keyboardType = self.pageItem?.uiProperties.keyboardType ?? .default
        formTextField.autocapitalizationType = self.pageItem?.uiProperties.autocapitalizationType ?? .sentences
        isSendButtonHidden = self.pageItem?.uiProperties.isCellButtonHidden
        
        checkItemValidity()
        self.pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
}

//MARK: - UITextFieldDelegate Methods

extension FormTextFieldTableViewCell: UITextFieldDelegate {
    
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        checkItemValidity()
        updateUIProperties()
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text, let stringRange = Range(range, in: currentText) else { return false }
        
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        return updatedText.count <= 85
    }
}

//MARK: - Private Methods

private extension FormTextFieldTableViewCell {
    @objc  func textFieldTapped(_ textField: UITextField) {
        pageItem?.isValid = true
        updateUIProperties()
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkItemValidity()
        updateUIProperties()
    }
    
    /// Checks if the item value is valid.
    func checkItemValidity() {
        guard let pageItem = pageItem else { return }
        
        pageItem.valueCompletion?(formTextField.text)
        pageItem.checkValidity()
    }
    
    /// Updates the border color and error message.
    func updateUIProperties() {
        guard let pageItem = pageItem else { return }
        //TODO: - Implement error messages
        
        pageItem.updateUIProperties(for: formTextField)
    }
    
    func toggleCellButtonHidden() {
        if self.pageItem?.uiProperties.isCellButtonHidden == true {
            cellButton.isHidden = true
        } else {
            cellButton.isHidden = false
        }
    }
}
