//
//  LanguageSelectionViewController.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/24/21.
//

import UIKit

class LanguageSelectionViewController: UIViewController {
    
    var form: Form?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func romanianButtonTapped() {
        guard let formContainerViewController = UIStoryboard(name: "RegistrationFlow", bundle: nil).instantiateViewController(withIdentifier: "FormContainerViewController") as? FormContainerViewController else { return }
       
        formContainerViewController.form = form
        
        navigationController?.pushViewController(formContainerViewController, animated: true)
    }
    
    @IBAction func englishButtonTapped() {
        guard let formContainerViewController = UIStoryboard(name: "RegistrationFlow", bundle: nil).instantiateViewController(withIdentifier: "FormContainerViewController") as? FormContainerViewController else { return }
       
        formContainerViewController.form = form
        
        navigationController?.pushViewController(formContainerViewController, animated: true)
    }
}
