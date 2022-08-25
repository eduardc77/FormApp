//
//  CollapsibleTableViewHeader.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/15/21.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {
    //MARK: - Properties
    
    let titleLabel = UILabel()
    let arrowLabel = UILabel()
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    
    //MARK: - Initialization
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public Methods
    
    func setCollapsed(_ collapsed: Bool) {
        arrowLabel.rotate(toValue: collapsed ? .pi : 0, duration: 0.2)
    }
}

//MARK: - Private Methods

private extension CollapsibleTableViewHeader {
    ///Toggle section when tapping on the header
    @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
        guard let header = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        
        delegate?.toggleSection(self, section: header.section)
    }
    
    func setupViews() {
        let marginGuide = contentView.layoutMarginsGuide
        
        // Content View
        contentView.backgroundColor = UIColor(named: "sectionColor")
        
        // ArrowLabel
        arrowLabel.textColor = UIColor.white
        contentView.addSubview(arrowLabel)
        
        //constraints
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        
        // TitleLabel
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        
        //constraints
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.numberOfLines = 0
    }
}
