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
    
    var background:BackgroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Prepare layout and add subviews
        background = BackgroundView(inView: self.view)
        self.view.addSubview(background)
        
        // gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        // This view controller itself will provide the delegate methods for text
        fromTextView.delegate = self
    }
    
    // MARK: - ALERT CONTROLLER
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - PREPARE ANIMATIONS
    
    override func viewWillAppear(_ animated: Bool) {
        background.start(at: CGFloat(Settings.shared.AnimBackgroundPos))
        self.fromTextView.alpha = 0
        self.toTextView.alpha = 0
    }

    // MARK: - LAUNCH ANIMATIONS
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        background.move(to: CGFloat(Settings.shared.AnimBackgroundRef) - (self.view.bounds.width * 2) )
        anim()
    }
    
    func anim() {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.fromTextView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.toTextView.alpha = 100
        }, completion: nil)
        
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        
    }
    
    // MARK: - HANDLE INPUTS
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        fromTextView.resignFirstResponder()
    }
    
    // MARK: - REQUEST FROM MODEL
    
    // detect language
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fromTextView.resignFirstResponder()
        
        if fromTextView.text != nil {
            TranslateService.shared.getLanguage(sentence: fromTextView.text!,
                                                completionHandler: { (success, erreur, language) in
                                                    if success == true {
                                                        self.translate(with: language!)
                                                    }else{
                                                        self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!) } })
            
        }else {
            presentUIAlertController(title: Settings.shared.errorTitle, message: Settings.shared.errorTyping)
        }
        
        return true
    }
    
    
    // Translate
    
    func translate (with language: String){
        
        TranslateService.shared.getTranslation(sentence: fromTextView.text!,
                                               source: language,
                                               completionHandler: { (success, erreur, translation) in
                                                if success == true {
                                                    self.toTextView.text = translation!.data.translations[0].translatedText
                                                }else{
                                                    self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!)
                                                } })
        
    }
    
    
    // MARK: - UPDATE VIEW
    

}
