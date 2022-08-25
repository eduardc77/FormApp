//
//  RadioButtonTableViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import UIKit

class RadioButtonTableViewCell: UITableViewCell, FormConformity, CellUpdatable {
    //MARK: - Outlets
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var radioButton: UISegmentedControl!
    @IBOutlet weak var errorLabel: UILabel!
    
    //MARK: - Properties
    
    var pageItem: PageItem?
    weak var cellUpdaterDelegate: CustomCellUpdater?
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupRadioButton()
        
    }
    
    //MARK: - Actions
    
    @IBAction func radioButtonTapped() {
        pageItem?.currentSegmentIndex = radioButton.selectedSegmentIndex
        checkItemValidity()
        cellUpdaterDelegate?.updateTableView()
    }
}

// MARK: - FormUpdatable

extension RadioButtonTableViewCell: FormUpdatable {
    func update(with pageItem: PageItem) {
        self.pageItem = pageItem
        self.titleLabel.text = self.pageItem?.title

        radioButton.replaceSegments(segments: self.pageItem?.segments ?? [])
        radioButton.selectedSegmentIndex = pageItem.currentSegmentIndex ?? 0
        
        checkItemValidity()
    }
}

//MARK: - Private Methods

private extension RadioButtonTableViewCell {
    ///Checks if the item value is valid and updates the border color and error message.
    func checkItemValidity() {
        guard let pageItem = pageItem else { return }

        pageItem.valueCompletion?(radioButton.titleForSegment(at: radioButton.selectedSegmentIndex))
        pageItem.checkValidity()
        pageItem.updateUIProperties(for: radioButton)
        pageItem.toggleErrorMessageHidden(for: errorLabel)
    }
    
    func setupRadioButton() {
        radioButton.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)], for: .normal)
        
        if #available(iOS 13, *) {} else {
            radioButton.backgroundColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 0.9531072149)
            radioButton.layer.borderColor = UIColor(named: "borderColor")?.cgColor
            radioButton.tintColor = .white
            radioButton.layer.cornerRadius = 4
            radioButton.layer.borderWidth = 1
            
            let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            radioButton.setTitleTextAttributes(titleTextAttributes, for:.normal)
            
            let titleTextAttributes1 = [NSAttributedString.Key.foregroundColor: UIColor.black]
            radioButton.setTitleTextAttributes(titleTextAttributes1, for:.selected)
        }
    }
}
