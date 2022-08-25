//
//  SuccessViewController.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/22/21.
//

import UIKit

class SuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = false
        navigationItem.hidesBackButton = true
    }
    
    //MARK: - Actions

    @IBAction func doneButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
