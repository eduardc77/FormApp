//
//  PageProgressCollectionViewCell.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/18/21.
//

import UIKit

class PageProgressCollectionViewCell: UICollectionViewCell {
    //MARK: - Outlets
    
    @IBOutlet weak var pageTitleLabel: UILabel!
    @IBOutlet weak var progressLineView: UIView!
    
    //MARK: - Properties
    
    var valueCompletion: ((Bool) -> Void)?
    
    //MARK: - View Life Cycle
    
    override func awakeFromNib() {
        progressLineView.backgroundColor = UIColor(named: "borderColor")
        pageTitleLabel.text = ""
    }
    
    //MARK: - Public Methods
    
    func setupCellWith(title: String) {
        self.pageTitleLabel.text = title
        
        valueCompletion = { [weak self] isActive in
            guard let self = self else { return }
            
            UIView.animate(withDuration: 0.6) { [unowned self] in
                self.progressLineView.backgroundColor = isActive ? UIColor(named: "selected.tab") : UIColor(named: "borderColor")
            }
            
        }
    }
}
