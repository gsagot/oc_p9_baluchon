//
//  Baluchon.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import Foundation

class Settings {
    
    static var shared = Settings()
    
    var posx:Float = 0
    
    var refX:Float = 0
    
    var jsonCurrencies: Data? {
        let bundle = Bundle(for: Settings.self)
        let url = bundle.url(forResource: "Currencies", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    var jsonWeatherParis: Data? {
        let bundle = Bundle(for: Settings.self)
        let url = bundle.url(forResource: "WeatherParis", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
     var jsonWeatherNY: Data? {
        let bundle = Bundle(for: Settings.self)
        let url = bundle.url(forResource: "WeatherNY", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    var currencies = [Currency]()
    
    var weathers = [WeatherResult]()
    
    private init() {
        
        let decoder = JSONDecoder()
        do{
            let product = try decoder.decode(ChangeResult.self, from: jsonCurrencies!)
            saveRates(from: product)
        }catch{
            print(error.localizedDescription)
        }
        
        do{
            let product = try decoder.decode(WeatherResult.self, from: jsonWeatherParis!)
            weathers.append(product)
        }catch{
            print(error.localizedDescription)
        }
        
        do{
            let product = try decoder.decode(WeatherResult.self, from: jsonWeatherNY!)
            weathers.append(product)
        }catch{
            print(error.localizedDescription)
        }
         
        
   
    }
    
    // MARK: - FUNCTIONS
    
    func formatTextForURLRequest(string:String)-> String {
        return string.replacingOccurrences(of: " ", with: "+")
    }
    
    func saveRates (from: ChangeResult) {
        
        currencies.append(Currency(code: "CHF",name:"Swiss Franc", rate:from.rates.CHF, icon: " ", amount: from.rates.CHF))
        currencies.append(Currency(code: "EUR",name:"Euro", rate:from.rates.EUR, icon: " ", amount: from.rates.EUR))
        currencies.append(Currency(code: "GBP",name:"British Pound Sterling", rate:from.rates.GBP, icon: " ", amount: from.rates.GBP))
        currencies.append(Currency(code: "USD",name:"United States Dollar", rate:from.rates.USD, icon: " ", amount: from.rates.USD))
        
        
    }

    
    

}
