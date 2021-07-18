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
        /*
        ChangeService.shared.getChange(completionHandler: { (success, error, current) in
            if success == true {
                ...
            }
            else {
                self.presentUIAlertController(title: "Error", message: error!)
                
            } })
         */
        
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)
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
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [
        UIColor.cyan.cgColor,UIColor.blue.cgColor]
        return layer
    }
    
    
    
    
    
    
    
}
