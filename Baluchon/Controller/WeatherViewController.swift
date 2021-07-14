//
//  ViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 26/06/2021.
//

import UIKit

class WeatherViewController: UIViewController {
    
    @IBOutlet var currentCityView: WeatherView!
    @IBOutlet var wantedCityView: WeatherView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        WeatherService.shared.getWeather(city: "Paris", completionHandler: { (success, erreur, current) in
            if success == true {
                //self.textLocationTempIn.text  = String(current!.main.temp)
            }
            else {
               // self.presentUIAlertController(title: "Error", message: erreur!)
                
            } })
        */
        self.view.layer.insertSublayer(gradient(frame: self.view.bounds), at:0)
        /*
        currentCityView.cityText.text = Settings.shared.weathers[0].name
        currentCityView.temperatureText.text = String(format: "%.0f", Settings.shared.weathers[0].main.temp ) + "°"
        currentCityView.descriptionText.text = Settings.shared.weathers[0].weather[0].description
        currentCityView.iconImage.image = UIImage(named: Settings.shared.weathers[0].weather[0].icon)
        currentCityView.iconImage.tintColor = UIColor.blue
        
        wantedCityView.cityText.text = Settings.shared.weathers[1].name
        wantedCityView.temperatureText.text = String(format: "%.0f", Settings.shared.weathers[1].main.temp ) + "°"
        wantedCityView.descriptionText.text = Settings.shared.weathers[1].weather[0].description
        wantedCityView.iconImage.image = UIImage(named: Settings.shared.weathers[1].weather[0].icon)
        wantedCityView.iconImage.tintColor = UIColor.blue
 */
        
        updateView(currentCityView, with: 0)
        updateView(wantedCityView, with: 1)
         

        
        
        }
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 0.0)
        layer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.colors = [
        UIColor.cyan.cgColor,UIColor.blue.cgColor]
        return layer
    }
    
    func updateView (_ view: WeatherView, with index: Int ) {
        view.cityText.text = Settings.shared.weathers[index].name
        view.temperatureText.text = String(format: "%.0f", Settings.shared.weathers[index].main.temp ) + "°"
        view.descriptionText.text = Settings.shared.weathers[index].weather[0].description
        view.iconImage.image = UIImage(named: Settings.shared.weathers[index].weather[0].icon)
        view.iconImage.tintColor = UIColor.blue
        
        
    }
 
    

    



}

