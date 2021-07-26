//
//  Baluchon.swift
//  Baluchon
//
//  Created by Gilles Sagot on 08/07/2021.
//

import Foundation

class Settings {
    
    static var shared = Settings()
    
    // MARK: - ANIMATION BACKGROUND VARIABLES
    
    var AnimBackgroundPos:Float = 0
    
    var AnimBackgroundRef:Float = 0
    
    // MARK: - APPLICATION VARIABLES
    
    enum Lang {
        case fr
        case en
    }
    
    var currentCity = "Paris"
    
    var currentLanguage = "en"
    
    var langAvailable = ["English","French"]
  
    var errorTitle = "Error"
    var errorReponseWeather = "Can't find city"
    var errorReponseCurrency = "invalid base currency"
    var errorReponseTranslate = "Error trying to translate"
    var errorReponseDetect = "Can't detect language"
    var errorJson = "An error occurred, please try again"
    var errorData = "Can't connect to the server, please verify your connexion"
    var errorTyping = "Typing error"
    var infoSettingsLanguage = "Language updated"
    var infoSettingsCity = "City updated"
    var labelSettingsCity = "A city to compare New York with :"
    var labelSettingsLang = "Select language : "
    var textDetectLanguageView = "Language detected : "
    
    // MARK: - PRIVATE
    
    private var currencies = [Currency]()
    
    private var weathers = [WeatherResult]()
    
    private init() {
        // Create data for tests offline
        // API requests will overwrite this data
        
        // Currencies ...
        let curencyData = CurrencyResult(base: "EUR",date:"2021-07-06",rates: Rates(USD: 1.184953, EUR: 1, GBP: 0.855412, CHF: 1.09357))
        
        currencies.append(Currency(code: "CHF", rate:curencyData.rates.CHF, icon: "franc", date: curencyData.date))
        currencies.append(Currency(code: "EUR", rate:curencyData.rates.EUR, icon: "euro", date: curencyData.date))
        currencies.append(Currency(code: "GBP", rate:curencyData.rates.GBP, icon: "sterling", date: curencyData.date))
        currencies.append(Currency(code: "USD", rate:curencyData.rates.USD, icon: "dollars", date: curencyData.date))
        
        // Weathers ...
        let weatherData = WeatherResult(weather: [Weather(description: "Description", icon: "10d")], main: Main(temp: 10, humidity: 79), name: "Paris", dt:1626215100)
        
        for _ in 0...1 {
            weathers.append(weatherData)
        }
   
    }
    
    // MARK: - FUNCTIONS TO STORE DATA FROM SERVICES
    
    func saveWeathersFirstIndex (from:WeatherResult) {
        weathers[0] = from
    }
    
    func saveWeathersLastIndex (from:WeatherResult) {
        weathers[1] = from
    }
    
    func readWeather (at index: Int)-> WeatherResult {
        return weathers[index]
    }
    
    func readCurrency (at index: Int)-> Currency {
        return currencies[index]
    }
    
    func getNumberOfCurrencies ()-> Int {
        return currencies.count
    }
    
    func saveRate (from: CurrencyResult) {
        currencies[0] = Currency(code: "CHF", rate:from.rates.CHF, icon: "franc", date: from.date)
        currencies[1] = Currency(code: "EUR", rate:from.rates.EUR, icon: "euro", date: from.date)
        currencies[2] = Currency(code: "GBP", rate:from.rates.GBP, icon: "sterling", date: from.date)
        currencies[3] = Currency(code: "USD", rate:from.rates.USD, icon: "dollars", date: from.date)
    }
    
    // MARK: - UTILS
    
    func getDate(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM YYYY - HH:mm"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    // MARK: - CHANGE APPLICATION LANGUAGE
    
    func changeLanguage (with language: Lang) {
        
        if language == .en {
            
            currentLanguage = "en"
            
            langAvailable[0] = "English"
            langAvailable[1] = "French"
            
            errorTitle = "Error"
            errorReponseWeather = "Can't find city"
            errorReponseCurrency = "invalid base currency"
            errorReponseTranslate = "Error trying to translate"
            errorReponseDetect = "Can't detect language"
            errorJson = "An error occurred, please try again"
            errorData = "Can't connect to the server, please verify your connexion"
            errorTyping = "Typing error"
            infoSettingsLanguage = "Language updated"
            infoSettingsCity = "City updated "
            labelSettingsCity = "A city to compare New York with :"
            labelSettingsLang = "Select language : "
            textDetectLanguageView = "Language detected : "
        }
        if language == .fr {
            
            currentLanguage = "fr"
            
            langAvailable[0] = "Anglais"
            langAvailable[1] = "Français"
            
            errorTitle = "Erreur"
            errorReponseWeather = "Ville non disponible"
            errorReponseCurrency = "La devise de base est invalide"
            errorReponseTranslate = "Erreur en essayant de traduire"
            errorReponseDetect = "Erreur en essayant de detecter la langue"
            errorJson = "Une erreur est survenue, veuillez réessayer svp"
            errorData = "Impossible de se connecter au serveur, vérifiez votre connexion"
            errorTyping = "Erreur de saisie"
            infoSettingsLanguage = "Langue mise à jour"
            infoSettingsCity = "Ville mise à jour : "
            labelSettingsCity = "Comparer New York avec une ville :"
            labelSettingsLang = "séléctionner une langue : "
            textDetectLanguageView = "Langue detectée : "
        }

    }

    
    

}
