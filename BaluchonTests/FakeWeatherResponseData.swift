//
//  FakeWeatherResponseData.swift
//  BaluchonTests
//
//  Created by Gilles Sagot on 30/06/2021.
//

import Foundation

class FakeResponseData {
    // MARK: - Data
    static var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var translateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Translate", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var detectCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Detect", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currencies", withExtension: "json")!
        return try! Data(contentsOf: url)
    }

    static let weatherIncorrectData = "erreur".data(using: .utf8)!
    
    static let translateIncorrectData = "erreur".data(using: .utf8)!
    
    static let detectIncorrectData = "erreur".data(using: .utf8)!
    
    static let currencyIncorrectData = "erreur".data(using: .utf8)!
    


    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!

    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!


    // MARK: - Error
    class WeatherError: Error {}
    static let weatherError = WeatherError()
    
    class TranslateError: Error {}
    static let translateError = TranslateError()
    
    class ChangeError: Error {}
    static let changeError = ChangeError()
    
    class DetectError: Error {}
    static let detectError = DetectError()
    
}
