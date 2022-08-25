//
//  PageItemCellType.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

enum PageItemCellType: String, CaseIterable {
    case textField = "FormTextFieldTableViewCell"
    case dropdown = "DropDownTableViewCell"
    case datePicker = "DatePickerTableViewCell"
    case radioButton = "RadioButtonTableViewCell"
    case checkbox = "CheckboxTableViewCell"
    case textView = "FormTextViewTableViewCell"
    
    static func registerCells(for tableView: UITableView) {
        //Register cells
        for cellType in self.allCases {
            tableView.register(cellType)
        }
        
        //Register section header
        tableView.register(CollapsibleTableViewHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: CollapsibleTableViewHeader.self))
    }
    
    func dequeueCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        switch self {
        case .textField:
            guard let textFieldCell = tableView.dequeueReusableCell(FormTextFieldTableViewCell.self, for: indexPath) else { fatalError("The dequeued cell is not an instance of FormTextFieldTableViewCell.") }
            
            
            return textFieldCell
        case .dropdown:
            guard let dropDownCell = tableView.dequeueReusableCell(DropDownTableViewCell.self, for: indexPath) else {
                fatalError("The dequeued cell is not an instance of DropDownTableViewCell.") }
            
            return dropDownCell
        case .datePicker:
            guard let dropDownCell = tableView.dequeueReusableCell( DatePickerTableViewCell.self, for: indexPath) else { fatalError("The dequeued cell is not an instance of DatePickerTableViewCell.") }
            
            return dropDownCell
        case .radioButton:
            guard let radioButtonCell = tableView.dequeueReusableCell(RadioButtonTableViewCell.self, for: indexPath) else {
                fatalError("The dequeued cell is not an instance of RadioButtonTableViewCell.") }
            
            return radioButtonCell
        case .checkbox:
            guard let checkboxCell = tableView.dequeueReusableCell( CheckboxTableViewCell.self, for: indexPath)  else { fatalError("The dequeued cell is not an instance of CheckboxTableViewCell.") }
            
            return checkboxCell
        case .textView:
            guard let textViewCell = tableView.dequeueReusableCell( FormTextViewTableViewCell.self, for: indexPath) else { fatalError("The dequeued cell is not an instance of FormTextViewTableViewCell.") }
            
            return textViewCell
        }
    }
}
