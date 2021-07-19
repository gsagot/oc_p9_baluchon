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
    
    var currentCity = "Paris"
    
    // language
    var errorReponseWeather = "Can't find city"
    var errorReponseCurrency = "invalid base currency"
    var errorReponseTranslate = "Error trying to translate"
    var errorReponseDetect = "Can't detect language"
    var errorJson = "An error occurred, please try again"
    var errorData = "Can't connect to the server, please verify your connexion"
    var errorTyping = "Typing error"
    
    
    var currentLanguage = "en"
    
    enum Lang {
        case fr
        case en
    }
    
    var language:Lang = .en {
        didSet {
            changeLang ()
        }
    }
    
    func changeLang () {
        
        if language == .en {
            
            currentLanguage = "en"
            
            errorReponseWeather = "Can't find city"
            errorReponseCurrency = "invalid base currency"
            errorReponseTranslate = "Error trying to translate"
            errorReponseDetect = "Can't detect language"
            errorJson = "An error occurred, please try again"
            errorData = "Can't connect to the server, please verify your connexion"
            errorTyping = "Typing error"
            
        }
        if language == .fr {
            
            currentLanguage = "fr"
            
            errorReponseWeather = "Ville non disponible"
            errorReponseCurrency = "La devise de base est invalide"
            errorReponseTranslate = "Erreur en essayant de traduire"
            errorReponseDetect = "Erreur en essayant de detecter la langue"
            errorJson = "Une erreur est survenue, essayant encore svp"
            errorData = "Impossible de se connecter au serveur, vérifiez votre connexion"
            errorTyping = "Erreur de saisie"
 
        }
        
        
    }
    
    // For local tests
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
        // For local tests
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
    
    func saveWeathersFirstIndex (from:WeatherResult) {
        weathers[0] = from
    }
    
    func saveWeathersLastIndex (from:WeatherResult) {
        weathers[1] = from
    }
    
    func saveRates (from: ChangeResult) {
        
        currencies.append(Currency(code: "CHF",name:"Swiss Franc", rate:from.rates.CHF, icon: " ", amount: from.rates.CHF))
        currencies.append(Currency(code: "EUR",name:"Euro", rate:from.rates.EUR, icon: " ", amount: from.rates.EUR))
        currencies.append(Currency(code: "GBP",name:"British Pound Sterling", rate:from.rates.GBP, icon: " ", amount: from.rates.GBP))
        currencies.append(Currency(code: "USD",name:"United States Dollar", rate:from.rates.USD, icon: " ", amount: from.rates.USD))
        
        
    }

    
    

}
