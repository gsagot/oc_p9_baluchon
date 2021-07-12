//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import UIKit

class TranslateViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var fromTextView: UITextField!
    @IBOutlet var toTextView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromTextView.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    // Alert Controller
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        fromTextView.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fromTextView.resignFirstResponder()

        if fromTextView.text != nil {
                TranslateService.shared.getTranslation(sentence: fromTextView.text!, completionHandler: { (success, erreur, translation) in
                    if success == true {
                        self.toTextView.text = translation!.data.translations[0].translatedText
                    }else{
                        self.presentUIAlertController(title: "Error", message: erreur!)
                    } })
        }else {
            
            presentUIAlertController(title: "Error", message: "Text invalid")
        }
        return true
    }
}