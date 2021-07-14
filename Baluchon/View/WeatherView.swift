//
//  WeatherView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 14/07/2021.
//

import UIKit

class WeatherView: UIView {
    
    var temperatureText = UITextField()
    var cityText = UITextView()
    var descriptionText = UITextView()
    var iconImage = UIImageView()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.3)

        print (self.frame.width," " , self.frame.height)
        
        temperatureText.frame = CGRect(x:10,y:self.frame.height - 140,width:240,height:64)
        temperatureText.textColor = UIColor.white
        temperatureText.backgroundColor = UIColor(white: 1, alpha: 0)
        temperatureText.font = UIFont(name: "HelveticaNeue-Bold", size: 64)
        temperatureText.text = "21" + "°"
        temperatureText.layer.cornerRadius = 10
        self.addSubview(temperatureText)
        
        cityText.frame = CGRect(x:10,y:10,width:240,height:64)
        cityText.textColor = UIColor.white
        cityText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 42)
        cityText.text = "Paris"
        self.addSubview(cityText)
        
        descriptionText.frame = CGRect(x:10,y:self.frame.height - 60,width:self.frame.width,height:60)
        descriptionText.textColor = UIColor.white
        descriptionText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        descriptionText.font = UIFont(name: "HelveticaNeue-Bold", size: 32)
        descriptionText.text = "Scatered cloud "
        self.addSubview(descriptionText)
        
        iconImage.frame = CGRect(x:210,y:self.frame.height - 145,width:100,height:100)
        iconImage.image = UIImage(named: "02n")
        iconImage.tintColor = UIColor.blue
        //iconImage.backgroundColor = UIColor.blue
        self.addSubview(iconImage)
         
        
        self.layer.cornerRadius = 10
        
        
    }
    
}
