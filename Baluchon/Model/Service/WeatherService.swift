//
//  QuoteService.swift
//  ClassQuote
//
//  Created by Gilles Sagot on 23/06/2021.
//

import Foundation

class WeatherService {
    
    static var shared = WeatherService()
    
    private var weatherSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    //set url
    private static var location = String(" ")
    
    private static var weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=New+York&appid=\(key.weather)&lang=fr&units=metric")!

    //init()
    private init () {}

    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    func getWeather(city: String, completionHandler: @escaping ((Bool, String?, WeatherResult?) -> Void)) {
        WeatherService.location = city
        
        var request = URLRequest(url: WeatherService.weatherUrl)
        request.httpMethod = "POST"
        
        task?.cancel()
        
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print ("ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, "Can't connect to the server, please verify your connexion",nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print ("ERROR: \(String(describing: response))")
                    completionHandler (false, "Can't find city", nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(WeatherResult.self, from: data) else {
                    print("JSON ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, "An error occurred, please try again", nil)
                    return
                }
                
                completionHandler (true, nil, result)
            }
        }

        task?.resume()
    
    }
    
    
    

}
