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
    
    var bringUpToDateView:UpdateView!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Prepare layout and add subviews
        let frame = self.view
        let gradientView = GradientView(inView: frame!)
        self.view.addSubview(gradientView)
        self.view.sendSubviewToBack(gradientView)
        
        // Create Views
        wantedCityView = WeatherView(inView: frame!)
        currentCityView = WeatherView(inView: frame!)
        background = BackgroundView(inView: frame!)
        bringUpToDateView = UpdateView(inView: frame!)
        
        // Layout 
        wantedCityView.center.y += 30
        currentCityView.frame = wantedCityView.frame.offsetBy(dx: 0, dy: currentCityView.frame.maxY )
        
        view.addSubview(wantedCityView)
        view.addSubview(currentCityView)
        view.addSubview(bringUpToDateView)
        
        updateView(wantedCityView, with: 0 )
        updateView(currentCityView, with: 1 )

        // Prepare animations
        Settings.shared.AnimBackgroundRef = Float(background.center.x)
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        view.addSubview(background)
        
        // gesture recognizer
        let updateTap = UITapGestureRecognizer(target: self, action: #selector(self.updateWeather(_:)))
        self.bringUpToDateView.refreshButton.addGestureRecognizer(updateTap)
         
        }
    
    // MARK: - ALERT CONTROLLER
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    // MARK: - PREPARE ANIMATIONS AND REQUEST WEATHER
    
    // Prepare everytime the Controller will be current
    override func viewWillAppear(_ animated: Bool) {
        // Request Weather
        firstWeather()
        // Set Alpha for Views
        currentCityView.alpha = 0
        wantedCityView.alpha = 0
        bringUpToDateView.alpha = 0
        bringUpToDateView.center.y -= 50
        
        // Set Background skyline position...
        background.start(at: CGFloat(Settings.shared.AnimBackgroundPos))
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
        UIView.animate(withDuration: 0.5, delay: 0.8, options: [], animations: {
            self.bringUpToDateView.center.y += 50
            self.bringUpToDateView.alpha = 100
        }, completion: nil)
        // ... Then store Background skyline position. It will be the start position in the next controller
        Settings.shared.AnimBackgroundPos = Float(background.center.x)
        
        
    }
    
    @objc func updateWeather(_ sender: UITapGestureRecognizer? = nil) {
        firstWeather()
        
    }
    
    // MARK: - REQUEST FROM MODEL
    
    // Get weather first for Paris.
    func firstWeather () {
        let city = Settings.shared.getCurrentCity()
        let lang = Settings.shared.getCurrentLanguage()
        WeatherService.shared.getWeather(city:city, lang:lang ,completionHandler: { (success, erreur, current) in
                                            if success == true {
                                                // Store in weather array
                                                Settings.shared.saveWeathersFirstIndex(from: current!)
                                                self.secondWeather()
                                                self.updateView(self.wantedCityView, with: 0)
                                            }
                                            else {
                                                self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!)
                                                
                                            } })
    }
    
    // Then for New York.
    func secondWeather () {
        let city = "New+York"
        let lang = Settings.shared.getCurrentLanguage()
        WeatherService.shared.getWeather(city:city, lang:lang, completionHandler: { (success, erreur, current) in
            if success == true {
                // Store in weather array
                Settings.shared.saveWeathersLastIndex(from: current!)
                self.updateView(self.currentCityView, with: 1)
            }
            else {
                self.presentUIAlertController(title: Settings.shared.errorTitle, message: erreur!)
                
            } })
    }
    
    // MARK: - UPDATE VIEW
    
    func updateView(_ view: WeatherView, with index: Int ) {
        // Get city name
        let city = Settings.shared.readWeather(at: index).name
        // Get Weather temp for this location
        let temp = Settings.shared.readWeather(at: index).main.temp
        // Get Description
        let description = Settings.shared.readWeather(at: index).weather[0].description
        // Need icon for anim
        let weatherIcon = Settings.shared.readWeather(at: index).weather[0].icon
        // Use the same icon for night or day so replace the 'n' by 'd'
        let iconAnim = formatTextForURLRequest(string:weatherIcon)
        // Date to display last update
        let updateTime = Settings.shared.readWeather(at: index).dt
        
        // Update views
        view.cityText.text = city
        if view.cityText.text.count > 16 {
            view.cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 21)
        }else {
            view.cityText.font = UIFont(name: "HelveticaNeue-Bold", size: 28)
        }
        view.temperatureText.text = String(format: "%.0f", temp ) + "°"
        view.descriptionText.text = description
        
        // Get Date in weather dt and transform it in something readable for human
        self.bringUpToDateView.lastUpdateText.text = Settings.shared.getDate(dt: updateTime)

        // Build animation
        view.iconImage.animationImages = animatedImages(for: iconAnim)
        view.iconImage.animationDuration = 0.9
        view.iconImage.animationRepeatCount = .zero
        view.iconImage.image = view.iconImage.animationImages?.first
        view.iconImage.startAnimating()
        
        
    }
    
    // MARK: - UTILS
    
    // Create frames array for animationImages
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

