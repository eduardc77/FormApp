//
//  FormValidationProtocol.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/14/21.
//

/// Conform receiver to have data validation behavior
protocol FormValidable {
    var isValid: Bool { get set }
    var isMandatory: Bool { get set }
    func checkValidity()
}
