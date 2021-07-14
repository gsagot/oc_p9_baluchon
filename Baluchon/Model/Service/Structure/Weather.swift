//
//  weather.swift
//  ClassQuote
//
//  Created by Gilles Sagot on 26/06/2021.
//

import Foundation

struct Weather: Codable {
    var description: String
    var icon: String
    
}

struct Main: Codable {
    var temp: Double
    var humidity: Double
    
}

struct WeatherResult: Codable {
    var weather: [Weather]
    var main: Main
    var name: String
}
