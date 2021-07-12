//
//  WeatherTableViewController.swift
//  Baluchon
//
//  Created by Gilles Sagot on 28/06/2021.
//

import UIKit

class WeatherTableViewController:  UITableViewController {
    
    var cities = ["New York", "Paris", "London"]
    var temps = ["21","18","19"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 1 / ( 255/183), green: 1 / (255/215), blue: 1 / (255/229), alpha: 1)
        

        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    

    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath:IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "Localisation", for: indexPath) as! CityTableViewCell
    
   
        cell.cityLabel.text = cities[indexPath.row]
        cell.cityLabel.textColor = UIColor.darkGray
        cell.tempLabel.text = temps[indexPath.row] + "°C"
        update(icon:"09d",completionHandler: { (completion, data) in
            if completion == true {
                DispatchQueue.main.async {
                    cell.weatherImage.image = data!
                }
            }
        })
    
        return cell
    }
    
    func update(icon: String, completionHandler: @escaping ((Bool, UIImage?) -> Void)) {
        
        if let url = URL(string: "http://openweathermap.org/img/wn/" + "\(icon)" + "@2x.png") {
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if error != nil {
                    print("ERROR : \(String(describing: error?.localizedDescription))")
                    completionHandler (false,nil)
                }
                else{
                   completionHandler(true,UIImage(data: data!))
               }
           }
           
           task.resume()
       }

   }
 
    
}

class CityTableViewCell: UITableViewCell {
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherImage: UIImageView!
}
