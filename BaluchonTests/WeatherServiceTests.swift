//
//  BaluchonTests.swift
//  BaluchonTests
//
//  Created by Gilles Sagot on 30/06/2021.
//

import XCTest

@testable import Baluchon

class WeatherServiceTests: XCTestCase {

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
        measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.weatherError))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherIncorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't find city")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "An error occurred, please try again")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetWeatherShouldPostSuccessCallbackIfCorrectResponseWithData() {
        // Given
        let weatherService = WeatherService(
            weatherSession: URLSessionFake(
                data: FakeResponseData.weatherCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler: { (success, error, current) in

        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssert(current?.main.temp == 293.09)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
 
    
    
    
    //PROTOCOL TESTS///////////////////////////////////////////////
    // ////////////////////////////////////////////////////////////
    
 
    func testGetWeatherByProtocolShouldPostFailedCallbackIfError() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = FakeResponseData.weatherError
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    
    func testGetWeatherByProtocolShouldPostFailedCallbackIfNoData() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion" )
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    

    func testGetWeatherByProtocolShouldPostFailedCallbackIfIncorrectResponse() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = FakeResponseData.weatherIncorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseKO
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't find city" )
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)

    }
    
    
    func testGetWeatherByProtocolShouldPostFailedCallbackIfIncorrectData() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = FakeResponseData.weatherIncorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "An error occurred, please try again" )
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
        
    }
    
    func testGetWeatherByProtocolShouldPostSuccessCallbackIfCorrectResponseWithData() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = FakeResponseData.weatherCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let weatherService = WeatherService(weatherSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather (city:"New+York",lang:"en",completionHandler:{ (success, error, current) in
        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssert(current?.main.temp == 293.09)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
  
}


