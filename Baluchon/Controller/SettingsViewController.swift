//
//  AccueilViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import UIKit

class SettingsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate {

    var cogImageView = UIImageView()
    var background:BackgroundView!
    var settingsView:SettingsView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view
        let gradientView = GradientView(inView: frame!)
        self.view.addSubview(gradientView)
        self.view.sendSubviewToBack(gradientView)
        
        
        // Prepare layout and add subviews
        background = BackgroundView(inView: frame!)
        settingsView = SettingsView(inView: frame!)
        self.view.addSubview(cogImageView)
        self.view.addSubview(settingsView)
        self.view.addSubview(background)
      
        // This view controller itself will provide the delegate methods for the picker view and text
        settingsView.cityText.delegate = self
        settingsView.picker.delegate = self
        settingsView.picker.dataSource = self
        
        
        // gesture recognizer
        let validationForCity = UITapGestureRecognizer(target: self, action: #selector(self.handleValidationForCity(_:)))
        self.settingsView.valideCityButton.addGestureRecognizer(validationForCity)
        
        let validationForlang = UITapGestureRecognizer(target: self, action: #selector(self.handleValidationForlang(_:)))
        self.settingsView.valideLangButton.addGestureRecognizer(validationForlang)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    // MARK: - ALERT CONTROLLER
    
    @objc private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - PREPARE ANIMATIONS
    
    override func viewWillAppear(_ animated: Bool) {
        background.start(at: CGFloat(Settings.shared.AnimBackgroundPos))
    }
    
    // MARK: - LAUNCH ANIMATIONS
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        background.move(to: CGFloat(Settings.shared.AnimBackgroundRef) - (self.view.bounds.width * 3))
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        anim()
        
    }
    
    // MARK: - HANDLE INPUTS
    
    @objc func handleValidationForCity(_ sender: UITapGestureRecognizer? = nil) {
        if settingsView.cityText.text != nil {
            // Avoid space for weather request and replace by "+"
            // Also add "+" to the end : without Lyon become arrondissement de Lyon...
            let cityTextFormated = Settings.shared.formatTextForURLRequest(string: settingsView.cityText.text!) + "+"
            let languageSelected = Settings.shared.getCurrentLanguage()
            WeatherService.shared.getWeather(city: cityTextFormated,lang: languageSelected, completionHandler: { (success, erreur, current) in
                                                if success == true {
                                                    Settings.shared.setCurrentCity(cityTextFormated)
                                                    print ("Current City: \( Settings.shared.getCurrentCity() )" )
                                                    self.presentUIAlertController(title: "Info", message: Settings.shared.infoSettingsCity )
                                                }
                                                else {
                                                    self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!)
                                                    
                                                } })
            
        }
    }
    
    @objc func handleValidationForlang(_ sender: UITapGestureRecognizer? = nil) {
        let choose = settingsView.picker.selectedRow(inComponent: 0)
        
        if choose == 0 {
            Settings.shared.changeLanguage(with: .en)
   
        }
        if choose == 1 {
            Settings.shared.changeLanguage(with: .fr)
        }
        print ("Current Language: \( Settings.shared.getCurrentLanguage() )" )
        updateView()
        self.presentUIAlertController(title: "Info", message: Settings.shared.infoSettingsLanguage)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        settingsView.cityText.resignFirstResponder()
        
    }
    
    func anim() {
        cogImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        cogImageView.center.x = self.view.center.x
        cogImageView.center.y = 100
        
        cogImageView.animationImages = animatedImages(for: "cog")
       
        cogImageView.animationDuration = 0.9
        cogImageView.animationRepeatCount = .zero
        cogImageView.image = cogImageView.animationImages?.first
        cogImageView.startAnimating()
        
        
    }
    
    
    // MARK: - PICKER VIEW LAYOUT
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Settings.shared.langAvailable.count
        
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
           if pickerLabel == nil {
               pickerLabel = UILabel()
            pickerLabel?.textAlignment = .natural
           }
        
        pickerLabel?.text = "    " + Settings.shared.langAvailable[row]
        pickerLabel?.textColor = UIColor.white

           return pickerLabel!
    }
    
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       // picker.subviews.last?.alpha = 0
        return langAvailable[row]
        
    }
     */
    
    // MARK: - UPDATE VIEW
    
    func updateView() {
        settingsView.cityLabel.text = Settings.shared.labelSettingsCity
        settingsView.langLabel.text = Settings.shared.labelSettingsLang
        settingsView.picker.reloadAllComponents()
    }
    
    // MARK: - UTILS
    
    func animatedImages(for name: String) -> [UIImage] {
        
        var i = 0
        var images = [UIImage]()
        
        while let image = UIImage(named: "\(name)_\(i)") {
            images.append(image)
            i += 1
        }
        return images
    }
   
    
    
    
    
    
    
    
}
