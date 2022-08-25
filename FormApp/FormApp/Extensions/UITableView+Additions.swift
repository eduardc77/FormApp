//
//  UITableView+Additions.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/20/21.
//

import UIKit

extension UITableView {
    open func dequeueReusableCell<Cell: UITableViewCell>(_ type: Cell.Type, for indexPath: IndexPath) -> Cell? {
        return self.dequeueReusableCell(withIdentifier: String(describing: type), for: indexPath) as? Cell
    }
    
    func register(_ type: PageItemCellType) {
        let nib = UINib(nibName: String(describing: type.rawValue), bundle: nil)
        register(nib, forCellReuseIdentifier: String(describing: type.rawValue))
    }
}
