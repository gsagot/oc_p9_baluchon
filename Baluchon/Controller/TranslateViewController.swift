//
//  TranslateViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import UIKit

class TranslateViewController: UIViewController, UITextViewDelegate {
    
 
    @IBOutlet var translateTextView: UITextView!
    @IBOutlet var detectTextView: UITextView!
    @IBOutlet var translateButton: UIButton!
    
    var background:BackgroundView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Prepare layout and add subviews
        let frame = self.view
        let gradientView = GradientView(inView: frame!)
        self.view.addSubview(gradientView)
        self.view.sendSubviewToBack(gradientView)
        background = BackgroundView(inView: frame!)
        self.view.addSubview(background)
        
        // gesture recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        let tapToTranslate = UITapGestureRecognizer(target: self, action: #selector(self.handleTapToTranslate(_:)))
        self.translateButton.addGestureRecognizer(tapToTranslate)
        
        // This view controller itself will provide the delegate methods for text
        translateTextView.delegate = self
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
        self.translateTextView.alpha = 0
        self.detectTextView.alpha = 0
        self.translateButton.alpha = 0
    }

    // MARK: - LAUNCH ANIMATIONS
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        background.move(to: CGFloat(Settings.shared.AnimBackgroundRef) - (self.view.bounds.width * 2) )
        anim()
    }
    
    func anim() {
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.translateTextView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.detectTextView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.translateButton.alpha = 100
        }, completion: nil)
        
       
        
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        
    }
    
    // MARK: - HANDLE INPUTS
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        translateTextView.resignFirstResponder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
           if(text == "\n") {
               textView.resignFirstResponder()
               return false
           }
           return true
       }
    
    // detect language
    
    @objc func handleTapToTranslate(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        if translateTextView.text != nil {
            TranslateService.shared.getLanguage(sentence: translateTextView.text!,
                                                completionHandler: { (success, erreur, language) in
                                                    if success == true {
                                                        self.translate(with: language!)
                                                        self.updateView(self.detectTextView,
                                                                        with:Settings.shared.textDetectLanguageView + language!)
                                                    }else{
                                                        self.presentUIAlertController(title: Settings.shared.errorTitle,
                                                                                      message: erreur!) } })
            
        }else {
            presentUIAlertController(title: Settings.shared.errorTitle,
                                     message: Settings.shared.errorTyping)
        }
    }
    
    // MARK: - REQUEST FROM MODEL
    
    // Translate
    
    func translate (with language: String){
        
        TranslateService.shared.getTranslation(sentence: translateTextView.text!,
                                               source: language,
                                               completionHandler: { (success, erreur, translation) in
                                                if success == true {
                                                    self.updateView(self.translateTextView,
                                                                    with: translation!.data.translations[0].translatedText)
                                                }else{
                                                    self.presentUIAlertController(title: Settings.shared.errorTitle,
                                                                                  message: erreur!)
                                                } })
        
    }
    
    
    // MARK: - UPDATE VIEW
    func updateView ( _ view: UITextView, with: String) {
        view.text = with
    }

}
