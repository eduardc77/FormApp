//
//  FormConformity.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

/// Conform the view receiver to be updated with a form item
protocol FormUpdatable {
    func update(with pageItem: PageItem)
}

/// Conform receiver to have a form item property
protocol FormConformity {
    var pageItem: PageItem? {get set}
}

protocol CellUpdatable: AnyObject {
    var cellUpdaterDelegate: CustomCellUpdater? { get set }
}
