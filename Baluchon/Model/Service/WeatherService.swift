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
    
 
    //init()
    private init () {}

    init(weatherSession: URLSession) {
        self.weatherSession = weatherSession
    }
    
    func getWeather(city: String, lang: String, completionHandler: @escaping ((Bool, String?, WeatherResult?) -> Void)) {
        
        let weatherUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(key.weather)&lang=\(lang)&units=metric")!
        
        var request = URLRequest(url: weatherUrl)
        request.httpMethod = "POST"
        
        task?.cancel()
        
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print ("ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, Settings.shared.errorData,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print ("ERROR: \(String(describing: response))")
                    completionHandler (false, Settings.shared.errorReponseWeather, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(WeatherResult.self, from: data) else {
                    print("JSON ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, Settings.shared.errorJson, nil)
                    return
                }
                
                completionHandler (true, nil, result)
            }
        }

        task?.resume()
    
    }
    

}
