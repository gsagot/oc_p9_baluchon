//
//  ViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 26/06/2021.
//

import UIKit

class WeatherViewController: UIViewController {

    
    @IBOutlet var textLocationIn: UITextField!
    @IBOutlet var textLocationTempIn: UITextField!
    @IBOutlet var imageWeatherLocationIn: UIImageView!
    
    @IBOutlet var textLocationFrom: UITextField!
    @IBOutlet var textLocationTempFrom: UITextField!
    @IBOutlet var imageWeatherLocationFrom: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        WeatherService.shared.getWeather(city: textLocationIn.text!, completionHandler: { (success, erreur, current) in
            if success == true {
                self.textLocationTempIn.text  = String(current!.main.temp)
            }
            else {
                self.presentUIAlertController(title: "Error", message: erreur!)
                
            } })
        
         

        
        
        }
    
    private func presentUIAlertController(title:String, message:String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(ac, animated: true, completion: nil)
    }
 
    

    



}

