//
//  DropDownTableViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

class DropDownTableViewCell: UITableViewCell, FormConformity, CellUpdatable {
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    
    var pageItem: PageItem?
    weak var cellUpdaterDelegate: CustomCellUpdater?
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupTextField()
        
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
        addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - FormUpdatable

extension DropDownTableViewCell: FormUpdatable {
    func update(with pageItem: PageItem) {
        self.pageItem = pageItem
        titleLabel.text = self.pageItem?.title
        selectTextField.text = self.pageItem?.value
        selectTextField.placeholder = self.pageItem?.placeholder
   
        //UI properties
        selectTextField.layer.borderColor = self.pageItem?.uiProperties.borderColor
        selectTextField.layer.borderWidth = self.pageItem?.uiProperties.borderWidth ?? 1
        self.pageItem?.toggleErrorMessageHidden(for: errorLabel)
        
        checkItemValidity()
    }
}

// MARK: - Private Methods

private extension DropDownTableViewCell {
    func setupPickerView() {
        let pickerView = UIPickerView()
        
        selectTextField.text = pageItem?.pickerComponents?[0]
        selectTextField.addDoneButtonToolbar()
        pickerView.dataSource = self
        pickerView.delegate = self
        selectTextField.inputView = pickerView
    }
    
    func setupTextField() {
        selectTextField.delegate = self
    }
    
    @objc func dropdownTapped() {
        if selectTextField.isFirstResponder {
            selectTextField.endEditing(true)
        } else {
            selectTextField.becomeFirstResponder()
            selectTextField.rightView?.rotate(toValue: .pi)
        }
    }
    
    /// Checks if the item value is valid.
    func checkItemValidity() {
        guard let pageItem = pageItem else { return }
        
        pageItem.valueCompletion?(selectTextField.text)
        pageItem.checkValidity()
    }
    
    /// Updates the border color and error message.
    func updateUIProperties() {
        pageItem?.updateUIProperties(for: selectTextField)
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
}

// MARK: - UIPickerViewDelegate Delegate, UIPickerViewDataSource

extension DropDownTableViewCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let components = pageItem?.pickerComponents else { return 0 }
        
        return components.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let components = pageItem?.pickerComponents else { return "" }
        
        return components[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //        selectTextField.endEditing(true)
        
        selectTextField.text = pageItem?.pickerComponents?[row]
    }
}

extension DropDownTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        selectTextField.rightView?.rotate(toValue: 0)
        
        checkItemValidity()
        updateUIProperties()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        setupPickerView()
        pageItem?.isValid = true
        updateUIProperties()
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
}
