//
//  Baluchon.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import Foundation

class Settings {
    
    static var shared = Settings()
    // MARK: - ANIMATION BACKGROUND
    
    var AnimBackgroundPos:Float = 0
    
    var AnimBackgroundRef:Float = 0
    
    // MARK: - DATAS
    
    var currentCity = "Paris"
    
    var currentLanguage = "en"
    
    // Data used by app - updated with language
    var errorTitle = "Error"
    var errorReponseWeather = "Can't find city"
    var errorReponseCurrency = "invalid base currency"
    var errorReponseTranslate = "Error trying to translate"
    var errorReponseDetect = "Can't detect language"
    var errorJson = "An error occurred, please try again"
    var errorData = "Can't connect to the server, please verify your connexion"
    var errorTyping = "Typing error"
    var infoSettingsLanguage = "Language updated : English"
    var infoSettingsCity = "City updated : "
    var labelSettingsCity = "Comparer New York avec une ville :"
    var labelSettingsLang = "Select language : "
    
    enum Lang {
        case fr
        case en
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
        
        currencies.append(Currency(code: "CHF",name:"Swiss Franc", rate:from.rates.CHF, icon: "franc", amount: from.rates.CHF))
        currencies.append(Currency(code: "EUR",name:"Euro", rate:from.rates.EUR, icon: "euro", amount: from.rates.EUR))
        currencies.append(Currency(code: "GBP",name:"British Pound Sterling", rate:from.rates.GBP, icon: "sterling", amount: from.rates.GBP))
        currencies.append(Currency(code: "USD",name:"United States Dollar", rate:from.rates.USD, icon: "dollars", amount: from.rates.USD))
    }
    
    func changeLanguage (with language: Lang) {
        
        if language == .en {
            
            currentLanguage = "en"
            
            errorTitle = "Error"
            errorReponseWeather = "Can't find city"
            errorReponseCurrency = "invalid base currency"
            errorReponseTranslate = "Error trying to translate"
            errorReponseDetect = "Can't detect language"
            errorJson = "An error occurred, please try again"
            errorData = "Can't connect to the server, please verify your connexion"
            errorTyping = "Typing error"
            infoSettingsLanguage = "Language updated : English"
            infoSettingsCity = "City updated : "
            labelSettingsCity = "A city to compare New York with :"
            labelSettingsLang = "Select language : "
        }
        if language == .fr {
            
            currentLanguage = "fr"
            
            errorTitle = "Erreur"
            errorReponseWeather = "Ville non disponible"
            errorReponseCurrency = "La devise de base est invalide"
            errorReponseTranslate = "Erreur en essayant de traduire"
            errorReponseDetect = "Erreur en essayant de detecter la langue"
            errorJson = "Une erreur est survenue, essayant encore svp"
            errorData = "Impossible de se connecter au serveur, vérifiez votre connexion"
            errorTyping = "Erreur de saisie"
            infoSettingsLanguage = "Langue mise à jour: Français"
            infoSettingsCity = "Ville mise à jour : "
            labelSettingsCity = "Comparer New York avec une ville :"
            labelSettingsLang = "séléctionner une langue : "
        }

    }

    
    

}
