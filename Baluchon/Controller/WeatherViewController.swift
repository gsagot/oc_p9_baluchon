//
//  ViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 26/06/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    var currentCityView: WeatherView!
    var wantedCityView: WeatherView!
    
    var background = UIImageView()
    var first = false
    var screen = CGRect()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        first = true
        currentCityView = WeatherView(inView: self.view)
        wantedCityView = WeatherView(inView: self.view)
        wantedCityView.frame = currentCityView.frame.offsetBy(dx: 0, dy: currentCityView.frame.maxY  + 30)
        
        view.addSubview(currentCityView)
        view.addSubview(wantedCityView)

        /*
        WeatherService.shared.getWeather(city: "Paris", completionHandler: { (success, erreur, current) in
            if success == true {
                //self.textLocationTempIn.text  = String(current!.main.temp)
            }
            else {
               // self.presentUIAlertController(title: "Error", message: erreur!)
                
            } })
        */
        
        backgroundInit()
        
        self.view.addSubview(background)
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)
        
        updateView(currentCityView, with: 0)
        updateView(wantedCityView, with: 1)
         
        }
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        currentCityView.alpha = 0
        wantedCityView.alpha = 0
        
        background.center.x = CGFloat(Settings.shared.posx)
        if first == true {
            background.frame.size.height = 0
            background.center.y += self.background.frame.width / 2
            
        }
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        
        backgroundAnim()
        
    }
    
    func backgroundInit() {
        
        screen = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        background.frame = CGRect(x: 0, y: screen.height - screen.width, width:screen.width * 3 , height: screen.width )
        background.image = UIImage(named: "Skyline")
        
        Settings.shared.posx = Float(background.center.x)
        Settings.shared.refX = Float(background.center.x)
        
        
    }
    
    func backgroundAnim() {
        
        if first == true {
        UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
                        self.background.frame.size.height = (self.screen.width * 3) / 3
                        self.background.center.y -= self.background.frame.width / 2 }, completion: nil)
            
        }
        
        UIView.animate(withDuration: 0.5) {
            self.background.center.x = CGFloat(Settings.shared.refX)
            
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: {
            self.currentCityView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.8, options: [], animations: {
            self.wantedCityView.alpha = 100
        }, completion: nil)
        
        Settings.shared.posx = Float(background.center.x)
        
        first = false
        
        
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
    
    func updateView (_ view: WeatherView, with index: Int ) {
        view.cityText.text = Settings.shared.weathers[index].name
        view.temperatureText.text = String(format: "%.0f", Settings.shared.weathers[index].main.temp ) + "°"
        view.descriptionText.text = Settings.shared.weathers[index].weather[0].description
        view.iconImage.image = UIImage(named: Settings.shared.weathers[index].weather[0].icon)
        view.iconImage.tintColor = UIColor.blue
        
        
    }
 
 
    

    



}

