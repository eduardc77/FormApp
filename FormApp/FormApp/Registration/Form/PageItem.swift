//
//  PageItem.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

/// UIKit properties for ViewModels
struct PageItemUIProperties {
    var borderColor = UIColor(named: "borderColor")?.cgColor
    var borderWidth: CGFloat = 1
    var tintColor = UIColor(named: "category.text")
    var keyboardType = UIKeyboardType.default
    var autocapitalizationType = UITextAutocapitalizationType .sentences
    var cellType: PageItemCellType?
    var isErrorMessageEmpty = true
    var isCellButtonHidden: Bool? = true
    
    //TODO: - For email textfield
    var isReadOnly: Bool = false
}

/// ViewModel to display and react to text events, to update data
final class PageItem: FormValidable {
    // MARK: Properties
    
    var title: String?
    var value: String?
    var placeholder: String?
    var pickerComponents: [String]?
    var indexPath: IndexPath?
    var valueCompletion: ((String?) -> Void)?
    var segments: [String]?
    var currentSegmentIndex: Int?
    var isMandatory = true
    var isValid = false //FormValidable protocol
    var uiProperties = PageItemUIProperties()
    
    //MARK: Initialization
    
    init(title: String? = nil, placeholder: String? = nil, value: String? = nil, cellType: PageItemCellType = .textField) {
        self.placeholder = placeholder
        self.value = value
        self.title = title
        uiProperties.cellType = cellType
    }
    
    // MARK: FormValidable
    
    func checkValidity() {
        if isMandatory {
            isValid = value != nil && value?.isEmpty == false
        } else {
            isValid = true
        }
    }
    
    func updateUIProperties(for view: UIView? = nil) {
        let validColor = UIColor(named: "borderColor")?.cgColor
        let errorColor = #colorLiteral(red: 0.8352941176, green: 0, blue: 0, alpha: 1).cgColor
        
        if self.isValid {
            view?.layer.borderColor = validColor
            view?.layer.borderWidth = 1
            uiProperties.borderColor = validColor
            uiProperties.borderWidth = 1
            uiProperties.isErrorMessageEmpty = true
        } else {
            view?.layer.borderColor = errorColor
            view?.layer.borderWidth = 2
            uiProperties.borderColor = errorColor
            uiProperties.borderWidth = 2
            uiProperties.isErrorMessageEmpty = false
        }
    }
    
    func toggleErrorMessageHidden(for label: UILabel) {
        if uiProperties.isErrorMessageEmpty == true {
            label.text = ""
        } else {
            switch uiProperties.cellType {
            case .checkbox:
                label.text = "Please check this if you want to proceed"
            case .radioButton:
                label.text = "Please select an option"
            default:
                if let title = title?.lowercased() {
                    label.text = "Please enter your \(title)."
                }
            }
        }
    }
}
