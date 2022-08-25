//
//  FormSelectionViewController.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/24/21.
//

import UIKit

class FormSelectionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //MARK: - Actions

    @IBAction func teamFormTapped() {
        guard let languageViewController = UIStoryboard(name: "RegistrationFlow", bundle: nil).instantiateViewController(withIdentifier: "LanguageSelectionViewController") as? LanguageSelectionViewController else { return }
        
        languageViewController.form = TeamRegistrationForm()
        
        navigationController?.pushViewController(languageViewController, animated: true)
    }
    
    
    @IBAction func teacherFormTapped() {
        guard let languageViewController = UIStoryboard(name: "RegistrationFlow", bundle: nil).instantiateViewController(withIdentifier: "LanguageSelectionViewController") as? LanguageSelectionViewController else { return }
       
        languageViewController.form = IndividualRegistrationForm()
        
        navigationController?.pushViewController(languageViewController, animated: true)
    }
}
