//
//  AccueilViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var langAvailable = ["English","French"]
    var picker = UIPickerView()
    var validateButton = UIButton()
    var cityText = UITextField()
    
    var background = UIImageView()
    var screen = CGRect()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundInit()
        self.view.addSubview(background)
        self.view.sendSubviewToBack(background)
        
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)
        
        picker.delegate = self
        picker.dataSource = self

        pickerCustomize()
        view.addSubview(picker)
        
        buttonCustomize()
        view.addSubview(validateButton)
        
        textCustomize()
        view.addSubview(cityText)
        
        cityText.delegate = self
        
        let validation = UITapGestureRecognizer(target: self, action: #selector(self.handleValidation(_:)))
        self.validateButton.addGestureRecognizer(validation)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        background.center.x = CGFloat(Settings.shared.posx)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        backgroundAnim()
        
    }
    
    // Animation...
    func backgroundInit() {
        
        screen = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        background.frame = CGRect(x: 0, y: screen.height - screen.width, width:screen.width * 4 , height: screen.width )
        background.image = UIImage(named: "Skyline2")
    
        
        
    }
    
    func backgroundAnim() {
        
        UIView.animate(withDuration: 0.5) {
            self.background.center.x = CGFloat(Settings.shared.refX) - (self.view.bounds.width * 3)
        }
        
        Settings.shared.posx = Float(background.center.x)
        
    }
    
    @objc func handleValidation(_ sender: UITapGestureRecognizer? = nil) {
        
        let choose = picker.selectedRow(inComponent: 0)
        if choose == 0 {
            Settings.shared.language = .en
            validateButton.setTitle("Validate", for: .normal)
        }
        if choose == 1 {
            Settings.shared.language = .fr
            validateButton.setTitle("Valider", for: .normal)
        }
        if cityText.text != nil {
            let cityFormated = formatTextForURLRequest(string: cityText.text!)
            WeatherService.shared.getWeather(city: cityFormated,lang: Settings.shared.currentLanguage , completionHandler: { (success, erreur, current) in
                if success == true {
                    print ("City is changed")
                    Settings.shared.currentCity = cityFormated
                }
                else {
                    self.presentUIAlertController(title: "Error", message: erreur!)
                    
                } })
            
            
        }
        print ("Current Language: \(Settings.shared.language)")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        cityText.resignFirstResponder()
        
    }
    
    func pickerCustomize() {
        picker.frame = CGRect(x: 0, y: 0, width: 260, height: 200)
        picker.center = self.view.center
        picker.setValue(UIColor.white, forKey: "textColor")
    }
    
    func buttonCustomize() {
        validateButton.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        validateButton.center = self.view.center
        validateButton.center.y +=  100
        validateButton.setTitle("Validate", for: .normal)
        validateButton.backgroundColor = UIColor.blue
    }
    
    func textCustomize() {
        cityText.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        cityText.center = self.view.center
        cityText.center.y -=  100
        cityText.backgroundColor = UIColor.white
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langAvailable.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        picker.subviews.last?.alpha = 0
        return langAvailable[row]
    }
    
    func formatTextForURLRequest(string:String)-> String {
        return string.replacingOccurrences(of: " ", with: "+")
    }
    
    
    // Alert Controller
    @objc private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
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
    
    
    
    
    
    
    
}
