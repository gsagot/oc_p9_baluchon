//
//  SettingsView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 22/07/2021.
//

import UIKit

class SettingsView : UIView {
    
    var picker = UIPickerView()
    var valideLanguageButton = UIButton()
    
    var cityText = UITextField()
    var cityLabel = UITextView()
    var langLabel = UITextView()
    var valideCityButton = UIButton()
    var valideLangButton = UIButton()
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        // Adapt the size of background to the size of the device
        // Appearance on every device
        
        let rect = CGRect(x: 0, y: 0, width: inView.frame.width, height: inView.frame.height)
        self.init(frame: rect)
        
        self.frame = inView.frame
       
        cityText.frame = CGRect(x: 20, y: 200, width: inView.frame.width - 100, height: 30)
        cityText.backgroundColor = UIColor.white
        cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        cityText.textColor = UIColor(red: 1 * (0/255), green: 1 * (122/255), blue: 1 * (255/255), alpha: 1 * (255/255) )
        self.addSubview(cityText)
        
        
        cityLabel.frame = CGRect(x: 10, y: 160, width: inView.frame.width, height: 30)
        cityLabel.backgroundColor = UIColor.init(white: 1, alpha: 0)
        cityLabel.text = "A city to compare New York with : "
        cityLabel.textColor = UIColor.white
        cityLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.addSubview(cityLabel)
        
        valideCityButton.frame = CGRect(x: cityText.frame.maxX + 10 , y: cityText.frame.minY, width: 50, height: 50)
        valideCityButton.center.y = cityText.center.y
        let imageSearch = UIImage(systemName: "magnifyingglass.circle.fill")
        valideCityButton.setBackgroundImage(imageSearch, for: .normal)
        self.addSubview(valideCityButton)
        
        langLabel.frame = CGRect(x: 10, y: cityText.frame.maxY + 60, width: inView.frame.width, height: 30)
        langLabel.backgroundColor = UIColor.init(white: 1, alpha: 0)
        langLabel.text = "Select language : "
        langLabel.textColor = UIColor.white
        langLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        self.addSubview(langLabel)
        
        picker.frame = CGRect(x: langLabel.frame.minX, y: langLabel.frame.maxY - 20, width: inView.frame.width - 100, height: 100)
        picker.setValue(UIColor.white, forKey: "textColor")
        self.addSubview(picker)
        
        valideLangButton.frame = CGRect(x: 0 , y: 0, width: 50, height: 50)
        valideLangButton.center.y = picker.center.y
        valideLangButton.center.x = valideCityButton.center.x
        let imageUpdate = UIImage(systemName: "arrow.clockwise.circle.fill")
        valideLangButton.setBackgroundImage(imageUpdate, for: .normal)
        self.addSubview(valideLangButton)
          
    }
    
}
