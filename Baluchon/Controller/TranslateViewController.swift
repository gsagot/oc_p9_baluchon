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
    
    var background = UIImageView()
    var screen = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fromTextView.delegate = self
        fromTextView.layer.cornerRadius = 10
        toTextView.layer.cornerRadius = 10
        
        backgroundInit()
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        background.center.x = CGFloat(Settings.shared.posx)
        self.fromTextView.alpha = 0
        self.toTextView.alpha = 0
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        backgroundAnim()
        
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
    
    // detect language
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        fromTextView.resignFirstResponder()
        
        if fromTextView.text != nil {
                TranslateService.shared.getLanguage(sentence: fromTextView.text!,
                                                    completionHandler: { (success, erreur, language) in
                                                        if success == true {
                                                            self.translate(with: language!)
                                                        }else{
                                                            self.presentUIAlertController(title: "Error", message: erreur!) } })
            
        }else {
            presentUIAlertController(title: "Error", message: "Text invalid")
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
                                                    self.presentUIAlertController(title: "Error", message: erreur!)
                                                } })
        
    }
    
    // background gradient
    func gradient(frame:CGRect) -> CAGradientLayer {

        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        let baseColor = UIColor(red: (80/255), green: (141/255), blue: (196/255), alpha: 1 * (255/255))
        let lightColor = modifie(color: baseColor, withAdditionalHue: 0, additionalSaturation: 0, additionalBrightness: 0.4)
        layer.colors = [baseColor.cgColor,lightColor.cgColor]
        
        return layer
    }
    // color modifier
    func modifie(color: UIColor, withAdditionalHue hue: CGFloat, additionalSaturation: CGFloat, additionalBrightness: CGFloat) -> UIColor {

        var currentHue: CGFloat = 0.0
        var currentSaturation: CGFloat = 0.0
        var currentBrigthness: CGFloat = 0.0
        var currentAlpha: CGFloat = 0.0

        if color.getHue(&currentHue, saturation: &currentSaturation, brightness: &currentBrigthness, alpha: &currentAlpha){
            return UIColor(hue: currentHue + hue,
                           saturation: currentSaturation + additionalSaturation,
                           brightness: currentBrigthness + additionalBrightness,
                           alpha: currentAlpha)
        } else {
            return color
        }
    }
    
    // Animation...
    func backgroundInit() {
        
        screen = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        background.frame = CGRect(x: 0, y: screen.height - screen.width, width:screen.width * 4 , height: screen.width )
        background.image = UIImage(named: "Skyline2")
    
        
        
    }
    
    func backgroundAnim() {
        
        UIView.animate(withDuration: 0.5) {
            self.background.center.x = CGFloat(Settings.shared.refX) - (self.view.bounds.width * 2)
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, options: [], animations: {
            self.fromTextView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.5, options: [], animations: {
            self.toTextView.alpha = 100
        }, completion: nil)
        
        Settings.shared.posx = Float(background.center.x)
        
    }
}
