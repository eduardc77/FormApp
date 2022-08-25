//
//  FormPage.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

import Foundation

final class FormPage {
    //MARK: Properties
    var title: String = ""
    
    var formSections = [PageSection]()
    
    //MARK: Initialization
    
    init(title: String, formSections: [PageSection]) {
        self.title = title
        self.formSections = formSections
    }
    
    // MARK: Form Validation
    
    @discardableResult
    func isValid() -> (validation: Bool, invalidItems: [String?]) {
        var isValid = true
        var invalidItems : [String?] = []
        
        formSections.forEach { section in
            section.items.forEach { item in
                if !item.isValid, item.isMandatory {
                    isValid = false
                    item.updateUIProperties()
                    invalidItems.append(item.title)
                }
            }
        }
        return (isValid, invalidItems)
    }
}
