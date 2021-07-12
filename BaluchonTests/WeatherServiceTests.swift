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
        weatherService.getWeather (city:"New York",completionHandler: { (success, error, current) in
            
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
        weatherService.getWeather (city:"New York",completionHandler: { (success, error, current) in
            
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
        weatherService.getWeather (city:"New York",completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't find city")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }

}
