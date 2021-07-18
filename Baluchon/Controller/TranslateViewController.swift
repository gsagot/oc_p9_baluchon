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
        fromTextView.layer.cornerRadius = 10
        toTextView.layer.cornerRadius = 10
        
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)
        
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
        /*
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
         */
        if fromTextView.text != nil {
                TranslateService.shared.getLanguage(sentence: fromTextView.text!, completionHandler: { (success, erreur, language) in
                    if success == true {
                        print(language!)
                        self.translate(with: language!)
                    
                    }else{
                        self.presentUIAlertController(title: "Error", message: "Can't detect language")
                    } })
        }else {
            
            presentUIAlertController(title: "Error", message: "Text invalid")
        }
         
        return true
    }
    
    func translate (with language: String){
        
        TranslateService.shared.getTranslation(sentence: fromTextView.text!,source: language, completionHandler: { (success, erreur, translation) in
                                                if success == true {
                                                    self.toTextView.text = translation!.data.translations[0].translatedText
                                                    
                                                }else{
                                                    self.presentUIAlertController(title: "Error", message: erreur!)
                                                } })
        
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
