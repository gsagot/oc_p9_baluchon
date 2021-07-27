//
//  SettingsTests.swift
//  BaluchonTests
//
//  Created by Gilles Sagot on 21/07/2021.
//

import XCTest

@testable import Baluchon

class SettingsTests: XCTestCase {
    

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testCurrentLanguageWhenChangeToEnglishLanguageThenCurrentLanguageShouldUpdate() {
        Settings.shared.changeLanguage(with: .en)
        XCTAssert(Settings.shared.getCurrentLanguage() == "en")
    }
    
    func testCurrentLanguageWhenChangeToFrenchLanguageThenCurrentLanguageShouldUpdate() {
        Settings.shared.changeLanguage(with: .fr)
        XCTAssert(Settings.shared.getCurrentLanguage() == "fr")
    }
    
    func testCurrentCityWhenChangeCityThenCurrentCityShouldUpdate() {
        Settings.shared.setCurrentCity("Bordeaux")
        XCTAssert(Settings.shared.getCurrentCity() == "Bordeaux")
    }
    
    
    func testSaveWeatherDataWhenGetWeatherThenDataShouldBeSavedinArrayAtIndexOne(){
        let weatherData = WeatherResult(weather: [Weather(description: "légère pluie", icon: "10d")], main: Main(temp: 293.09, humidity: 79), name: "Paris", dt: 1626215100)
        Settings.shared.saveWeathersLastIndex(from: weatherData)
        XCTAssert(Settings.shared.readWeather(at: 1).main.humidity == 79)
        
        
    }
    
    func testSaveWeatherDataWhenGetWeatherThenDataShouldBeSavedinArrayAtIndexZero(){
        let weatherData = WeatherResult(weather: [Weather(description: "légère pluie", icon: "10d")], main: Main(temp: 293.09, humidity: 79), name: "Paris", dt: 1626215100)
        Settings.shared.saveWeathersFirstIndex(from: weatherData)
        XCTAssert(Settings.shared.readWeather(at: 0).main.humidity == 79)

    }
    
    func testSaveCurrenciesDataWhenSaveCurrencyThenDataShouldBeSavedinArrayAtIndexZero(){
        let curencyData = CurrencyResult(base: "EUR",date:"2021-07-06",rates: Rates(USD: 1.184953, EUR: 1, GBP: 0.855412, CHF: 1.10358))
        Settings.shared.saveRate(from: curencyData)
        XCTAssert(Settings.shared.readCurrency(at: 0).rate == 1.10358)
        
      
    }
    
    

}
