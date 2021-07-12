//
//  AccueilViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // Alert Controller
    @objc private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func rates(){
        // TODO :

    }
    
    func weatherInNewYork(){
        // TODO :
        
    }
    
    
    
    
    
    
    
}
