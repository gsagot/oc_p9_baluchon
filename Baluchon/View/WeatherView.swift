//
//  WeatherView.swift
//  Baluchon
//
//  Created by Gilles Sagot on 14/07/2021.
//

import UIKit

class WeatherView: UIView {
    
    let temperatureText = UITextView()
    let cityText = UITextView()
    let descriptionText = UITextView()
    let iconImage = UIImageView()
    let borderView = UIView()
    
    //var weatherAnim = [UIImage]()
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(inView: UIView) {
        let rect = CGRect(x: 0, y: 30, width: inView.frame.width, height: 120.0)
        self.init(frame: rect)
        self.backgroundColor = UIColor(white: 1.0, alpha: 0.0)
        
        cityText.frame = CGRect(x:10,y:0,width:inView.frame.width - 10 ,height:40)
        cityText.textColor = UIColor.white
        cityText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        cityText.text = "City"
        cityText.isScrollEnabled = false
        cityText.isSelectable = false
        cityText.isEditable = false
        self.addSubview(cityText)
        
        descriptionText.frame = CGRect(x:10,y:cityText.frame.maxY,width:frame.width - 10,height:40)
        descriptionText.textColor = UIColor.white
        descriptionText.backgroundColor = UIColor(white: 1, alpha: 0.0)
        descriptionText.font = UIFont(name: "HelveticaNeue", size: 20)
        descriptionText.text = "Weather description "
        descriptionText.isScrollEnabled = false
        descriptionText.isSelectable = false
        descriptionText.isEditable = false
        self.addSubview(descriptionText)
        
        
        temperatureText.frame = CGRect(x:10,y:descriptionText.frame.maxY,width:240,height:50)
        temperatureText.center.y -= 10
        temperatureText.textColor = UIColor.white
        temperatureText.backgroundColor = UIColor(white: 1, alpha: 0)
        temperatureText.font = UIFont(name: "HelveticaNeue-Bold", size: 40)
        temperatureText.text = "0" + "°"
        temperatureText.isScrollEnabled = false
        temperatureText.isSelectable = false
        temperatureText.isEditable = false
        self.addSubview(temperatureText)
        
        iconImage.frame = CGRect(x:0,y:0,width:100,height:100)
        iconImage.center = CGPoint(x: self.bounds.width - 50 - 20, y: descriptionText.center.y)
        self.addSubview(iconImage)

    }

        
}
