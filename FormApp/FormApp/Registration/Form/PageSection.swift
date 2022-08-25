//
//  PageSection.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/15/21.
//

struct PageSection {
    // MARK: Properties
    
    var name: String
    var items: [PageItem] = []
    var isCollapsed: Bool = false
    
    //MARK: Initialization
    
    init(name: String) {
        self.name = name
    }
}
