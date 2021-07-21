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
    var valideLanguageButton = UIButton()
    
    var cityText = UITextField()
    var cityLabel = UITextView()
    var langLabel = UITextView()
    var valideCityButton = UIButton()
    var valideLangButton = UIButton()
    
    var background:BackgroundView!
    var screen = CGRect()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare layout and add subviews
        background = BackgroundView(inView: self.view)
        self.view.addSubview(background)
        //self.view.sendSubviewToBack(background)
        

        layout()
        view.addSubview(cityText)
        view.addSubview(cityLabel)
        view.addSubview(valideCityButton)
        view.addSubview(langLabel)
        view.addSubview(picker)
        view.addSubview(valideLangButton)
        
      
        // This view controller itself will provide the delegate methods for the picker view and text
        cityText.delegate = self
        picker.delegate = self
        picker.dataSource = self
        
        
        // gesture recognizer
        let validationForCity = UITapGestureRecognizer(target: self, action: #selector(self.handleValidationForCity(_:)))
        self.valideCityButton.addGestureRecognizer(validationForCity)
        
        let validationForlang = UITapGestureRecognizer(target: self, action: #selector(self.handleValidationForlang(_:)))
        self.valideLangButton.addGestureRecognizer(validationForlang)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        background.start(at: CGFloat(Settings.shared.posx))
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        background.translate(to: CGFloat(Settings.shared.refX) - (self.view.bounds.width * 3))
        
    }

    
    @objc func handleValidationForCity(_ sender: UITapGestureRecognizer? = nil) {
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
    }
    
    @objc func handleValidationForlang(_ sender: UITapGestureRecognizer? = nil) {
        let choose = picker.selectedRow(inComponent: 0)
        
        if choose == 0 {
            Settings.shared.changeLanguage(with: .en)
   
        }
        if choose == 1 {
            Settings.shared.changeLanguage(with: .fr)
        }
        print ("Current Language: \(Settings.shared.currentLanguage)")
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        cityText.resignFirstResponder()
        
    }
    
    
    func layout() {
        cityText.frame = CGRect(x: 10, y: 200, width: self.view.frame.width - 100, height: 30)
        cityText.backgroundColor = UIColor.white
        cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        
        cityLabel.frame = CGRect(x: 10, y: 160, width: self.view.frame.width, height: 30)
        cityLabel.backgroundColor = UIColor.init(white: 1, alpha: 0)
        cityLabel.text = "A city to compare New York with : "
        cityLabel.textColor = UIColor.white
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        valideCityButton.frame = CGRect(x: cityText.frame.maxX + 10 , y: cityText.frame.minY, width: 50, height: 50)
        valideCityButton.center.y = cityText.center.y
        let imageSearch = UIImage(systemName: "magnifyingglass.circle.fill")
        valideCityButton.setBackgroundImage(imageSearch, for: .normal)
            
        
        langLabel.frame = CGRect(x: 10, y: cityText.frame.maxY + 100, width: 180, height: 30)
        langLabel.backgroundColor = UIColor.init(white: 1, alpha: 0)
        langLabel.text = "Select language : "
        langLabel.textColor = UIColor.white
        langLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        picker.frame = CGRect(x: langLabel.frame.minX, y: langLabel.frame.maxY - 20, width: self.view.frame.width - 100, height: 100)
        picker.setValue(UIColor.white, forKey: "textColor")
        
        valideLangButton.frame = CGRect(x: 0 , y: 0, width: 50, height: 50)
        valideLangButton.center.y = picker.center.y
        valideLangButton.center.x = valideCityButton.center.x
        let imageUpdate = UIImage(systemName: "arrow.clockwise.circle.fill")
        valideLangButton.setBackgroundImage(imageUpdate, for: .normal)
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return langAvailable.count
        
    }
    
    /*
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       // picker.subviews.last?.alpha = 0
        return langAvailable[row]
        
    }
     */
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel: UILabel? = (view as? UILabel)
           if pickerLabel == nil {
               pickerLabel = UILabel()
            pickerLabel?.textAlignment = .natural
           }
        
        pickerLabel?.text = "    " + langAvailable[row]
        pickerLabel?.textColor = UIColor.white

           return pickerLabel!
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
    
   
    
    
    
    
    
    
    
}
