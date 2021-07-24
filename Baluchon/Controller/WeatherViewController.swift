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
    
    var background:BackgroundView!
 

    
    // Prepare once
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Prepare layout and add subviews
        wantedCityView = WeatherView(inView: self.view)
        currentCityView = WeatherView(inView: self.view)
        background = BackgroundView(inView: self.view)
        
        wantedCityView.center.y += 30
        currentCityView.frame = wantedCityView.frame.offsetBy(dx: 0, dy: currentCityView.frame.maxY )
        
        view.addSubview(wantedCityView)
        view.addSubview(currentCityView)
        

        // Prepare animations
        Settings.shared.AnimBackgroundRef = Float(background.center.x)
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        view.addSubview(background)
         
        }
    
    // MARK: - ALERT CONTROLLER
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - PREPARE ANIMATIONS
    
    // Prepare everytime the Controller will be current
    override func viewWillAppear(_ animated: Bool) {
        currentCityView.alpha = 0
        wantedCityView.alpha = 0
        // Set Background skyline position...
        background.start(at: CGFloat(Settings.shared.AnimBackgroundPos))
        
        // Request Weather
        firstWeather()
    }
    
    // MARK: - LAUNCH ANIMATIONS
    
    // Run Animation everytime the Controller become current
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidLoad()
        // Move Background skyline position...
        background.move(to: CGFloat(Settings.shared.AnimBackgroundRef))
        anim()
        
    }

    // Animation
    func anim() {
        
        UIView.animate(withDuration: 0.5, delay: 0.6, options: [], animations: {
            self.currentCityView.alpha = 100
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.8, options: [], animations: {
            self.wantedCityView.alpha = 100
        }, completion: nil)
        // ... Then store Background skyline position. It will be the start position in the next controller
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        
        
    }
    
    // MARK: - REQUEST FROM MODEL
    
    // Get weather for New York  then Paris on start : Can be changed in SettingsController next...
    func firstWeather () {
        WeatherService.shared.getWeather(city:Settings.shared.currentCity,lang: Settings.shared.currentLanguage , completionHandler: { (success, erreur, current) in
            if success == true {
                Settings.shared.saveWeathersFirstIndex(from: current!)
                self.secondWeather()
                self.updateView(self.wantedCityView, with: 0)
            }
            else {
                self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!)
                
            } })
    }
    
    func secondWeather () {
        WeatherService.shared.getWeather(city: "New+York",lang: Settings.shared.currentLanguage , completionHandler: { (success, erreur, current) in
            if success == true {
                Settings.shared.saveWeathersLastIndex(from: current!)
                self.updateView(self.currentCityView, with: 1)
            }
            else {
                self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!)
                
            } })
    }
    
    // MARK: - UPDATE VIEW
    
    func updateView(_ view: WeatherView, with index: Int ) {
        view.cityText.text = Settings.shared.weathers[index].name
        if view.cityText.text.count > 16 {
            view.cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
        }else {
            view.cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        }
        view.temperatureText.text = String(format: "%.0f", Settings.shared.weathers[index].main.temp ) + "°"
        view.descriptionText.text = Settings.shared.weathers[index].weather[0].description

        let icon = formatTextForURLRequest(string:Settings.shared.weathers[index].weather[0].icon)
        
        view.iconImage.animationImages = animatedImages(for: icon)
       
        view.iconImage.animationDuration = 0.9
        view.iconImage.animationRepeatCount = .zero
        view.iconImage.image = view.iconImage.animationImages?.first
        view.iconImage.startAnimating()
        
        
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
    
    
    func formatTextForURLRequest(string:String)-> String {
        return string.replacingOccurrences(of: "n", with: "d")
    }

    


}

