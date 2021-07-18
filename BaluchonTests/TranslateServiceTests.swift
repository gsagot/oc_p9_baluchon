//
//  TranslateServiceTests.swift
//  BaluchonTests
//
//  Created by Gilles Sagot on 06/07/2021.
//

import XCTest

@testable import Baluchon

class TranslateServiceTests: XCTestCase {

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
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.translateError))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(sentence:"Bonjour",source: "fr",completionHandler: { (success, error, translation) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(translation)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(sentence:"Bonjour",source: "fr",completionHandler: { (success, error, translation) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(translation)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.translateIncorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(sentence:"Bonjour",source:"fr",completionHandler: { (success, error, translation) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please try again")
            XCTAssertNil(translation)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }

    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.translateIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(sentence:"Bonjour",source:"fr",completionHandler: { (success, error, translation) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "An error occurred, please try again")
            XCTAssertNil(translation)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetTranslateShouldPostFailedCallbackIfCorrectResponseWithData() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.translateCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTranslation(sentence:"Bonjour",source:"fr",completionHandler: { (success, error, translation) in
            
        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssert(translation?.data.translations[0].translatedText == "Bonjour Monde")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    /* //////////////////////////////////////////////////////////////// */
    
    func testGetLanguageShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.detectError))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getLanguage(sentence:"Bonjour", completionHandler: { (success, error, lang) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(lang)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetLanguageShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(data: nil, response: nil, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getLanguage(sentence:"Bonjour",completionHandler: { (success, error, lang) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(lang)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetLanguageShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.detectIncorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getLanguage(sentence:"Bonjour",completionHandler: { (success, error, lang) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please try again")
            XCTAssertNil(lang)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }

    
    func testGetLanguageShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.detectIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getLanguage(sentence:"Bonjour",completionHandler: { (success, error, lang) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "An error occurred, please try again")
            XCTAssertNil(lang)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetLanguageShouldPostFailedCallbackIfCorrectResponseWithData() {
        // Given
        let translateService = TranslateService(
            translateSession: URLSessionFake(
                data: FakeResponseData.detectCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getLanguage(sentence:"Bonjour",completionHandler: { (success, error, lang) in
            
        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssert(lang == "fr")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    


}

