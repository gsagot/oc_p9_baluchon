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
    
    var langAvailable = [String]()
  
    var errorTitle:String!
    var errorReponseWeather:String!
    var errorReponseCurrency:String!
    var errorReponseTranslate:String!
    var errorReponseDetect:String!
    var errorJson:String!
    var errorData:String!
    var errorTyping:String!
    var infoSettingsLanguage:String!
    var infoSettingsCity:String!
    var labelSettingsCity:String!
    var labelSettingsLang:String!
    var textDetectLanguageView:String!
    var placeHolderTranslateView:String!
    
    // MARK: - PRIVATE
    
    private var currencies = [Currency]()
    
    private var weathers = [WeatherResult]()
    
    private var currentCity = "Paris"
    
    private var currentLanguage = "en"
    
    private init() {
        // Create data for tests offline
        // API requests will overwrite this data
        
        // Currencies ...
        let curencyData = CurrencyResult(base: "EUR",date:"2021-07-06",rates: Rates(USD: 1.184953, EUR: 1, GBP: 0.855412, CHF: 1.09357))
        
        currencies.append(Currency(code: "USD", rate:curencyData.rates.USD, icon: "dollars", date: curencyData.date))
        currencies.append(Currency(code: "GBP", rate:curencyData.rates.GBP, icon: "sterling", date: curencyData.date))
        currencies.append(Currency(code: "CHF", rate:curencyData.rates.CHF, icon: "franc", date: curencyData.date))
        currencies.append(Currency(code: "EUR", rate:curencyData.rates.EUR, icon: "euro", date: curencyData.date))
        
        // Weathers ...
        let weatherData = WeatherResult(weather: [Weather(description: "Description", icon: "10d")], main: Main(temp: 10, humidity: 79), name: "Paris", dt:1626215100)
        
        for _ in 0...1 {
            weathers.append(weatherData)
        }
        
        // Language
        changeLanguage ( with: .en)
   
    }
    
    // MARK: - FUNCTIONS TO STORE DATA FROM SERVICES
    
    func getCurrentCity()-> String{
        return currentCity
    }
    
    func getCurrentLanguage()-> String{
        return currentLanguage
    }
    
    func setCurrentCity(_ city:String) {
        currentCity = city
    }
    
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
        currencies[0] = Currency(code: "USD", rate:from.rates.USD, icon: "dollars", date: from.date)
        currencies[1] = Currency(code: "GBP", rate:from.rates.GBP, icon: "sterling", date: from.date)
        currencies[2] = Currency(code: "CHF", rate:from.rates.CHF, icon: "franc", date: from.date)
        currencies[3] = Currency(code: "EUR", rate:from.rates.EUR, icon: "euro", date: from.date)
    }
    
    // MARK: - UTILS
    
    func getDate(dt: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(dt))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MM YYYY - HH:mm"
        let result = dateFormatter.string(from: date)
        return result
    }
    
    func formatTextForURLRequest(string:String)-> String {
        return string.replacingOccurrences(of: " ", with: "+")
    }
    
    func formatTextForView(string:String)-> String {
        return string.replacingOccurrences(of: "+", with: " ")
    }
    
    func formatTextForIconAnim(string:String)-> String {
        return string.replacingOccurrences(of: "n", with: "d")
    }

    // MARK: - CHANGE APPLICATION LANGUAGE
    
    func changeLanguage (with language: Lang) {
        
        if language == .en {
            
            currentLanguage = "en"
            
            langAvailable = ["English","French"]

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
            placeHolderTranslateView = "Text to translate here"
        }
        if language == .fr {
            
            currentLanguage = "fr"
            
            langAvailable = ["Anglais","Français"]
            
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
            placeHolderTranslateView = "Texte à traduire ici"
        }

    }

    
    

}
