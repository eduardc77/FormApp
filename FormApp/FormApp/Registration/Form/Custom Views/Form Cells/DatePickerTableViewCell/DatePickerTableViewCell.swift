//
//  DatePickerTableViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/17/21.
//

import UIKit

class DatePickerTableViewCell: UITableViewCell, FormConformity, CellUpdatable {
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!

    
    //MARK: - Properties
    
    var pageItem: PageItem?
    weak var cellUpdaterDelegate: CustomCellUpdater?
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        
        datePicker.addTarget(self, action: #selector(datePickerDidChange(_:)), for: .valueChanged)
    
        return datePicker
    }()
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        setupTextField()

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dropdownTapped))
        addGestureRecognizer(gestureRecognizer)
    }
}

// MARK: - FormUpdatable

extension DatePickerTableViewCell: FormUpdatable {
    func update(with pageItem: PageItem) {
        self.pageItem = pageItem
        titleLabel.text = self.pageItem?.title
        if let selectedValue = self.pageItem?.value {
            selectTextField.text = selectedValue
        } else {
            selectTextField.placeholder = self.pageItem?.placeholder
        }
        //UI properties
        selectTextField.layer.borderColor = self.pageItem?.uiProperties.borderColor
        selectTextField.layer.borderWidth = self.pageItem?.uiProperties.borderWidth ?? 1
        self.pageItem?.toggleErrorMessageHidden(for: errorLabel)
        
        if pageItem.isValid, self.pageItem?.value != nil {
            checkItemValidity()
        }
    }
}

// MARK: - Private Methods

private extension DatePickerTableViewCell {
    func setupTextField() {
        selectTextField.delegate = self
        selectTextField.inputView = datePicker
        selectTextField.addDoneButtonToolbar()
    }
    
    @objc func dropdownTapped() {
        if selectTextField.isFirstResponder {
            selectTextField.endEditing(true)
        } else {
            selectTextField.becomeFirstResponder()
        }
    }
    
    @objc func datePickerDidChange(_ datePicker: UIDatePicker) {
        let stringDate = dateFormatter.string(from: datePicker.date)
        selectTextField.text = stringDate
    }
    
    func isBirthYearValid() -> Bool {
        let selectedYearDateComponents = Calendar.current.dateComponents([.year], from: datePicker.date)
        let currentYearDateComponents = Calendar.current.dateComponents([.year], from: Date())
        
        if let selectedYear = selectedYearDateComponents.year, let currentYear = currentYearDateComponents.year, selectedYear > currentYear {
            pageItem?.value = nil
            selectTextField.text = nil
            self.pageItem?.valueCompletion?(nil)
            self.pageItem?.checkValidity()
            updateUIProperties()
            
            return false
        }
        return true
    }
    
    /// Checks if the item value is valid.
    func checkItemValidity() {
        guard let pageItem = pageItem else { return }
        
        let stringDate = dateFormatter.string(from: datePicker.date)
        selectTextField.text = stringDate
        self.pageItem?.valueCompletion?(stringDate)
        
        pageItem.checkValidity()
    }
    
    /// Updates the border color and error message.
    func updateUIProperties() {
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
        self.pageItem?.updateUIProperties(for: selectTextField)
    }
}

extension DatePickerTableViewCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard isBirthYearValid() else { return }
        
        checkItemValidity()
        updateUIProperties()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        pageItem?.isValid = true
        updateUIProperties()
        pageItem?.toggleErrorMessageHidden(for: errorLabel)
    }
}
