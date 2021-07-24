//
//  ChangeServiceTests.swift
//  BaluchonTests
//
//  Created by Gilles Sagot on 06/07/2021.
//

import XCTest

@testable import Baluchon

class ChangeServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        ChangeService.shared.start()
    }

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
    
    func testGetChangeShouldPostFailedCallbackIfError() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.changeError))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorData)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetChangeShouldPostFailedCallbackIfNoData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorData)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetChangeShouldPostFailedCallbackIfIncorrectResponse(){
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeResponseData.changeIncorrectData,
                response: FakeResponseData.responseKO,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorReponseCurrency)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    
    func testGetChangeShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeResponseData.changeIncorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorJson)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetChangeShouldPostSuccessCallbackIfCorrectResponseWithData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(
                data: FakeResponseData.changeCorrectData,
                response: FakeResponseData.responseOK,
                error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssert(current?.rates.EUR == 1)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
 
    //PROTOCOL TESTS///////////////////////////////////////////////
    // ////////////////////////////////////////////////////////////
    
    func testGetChangeByProtocolShouldPostFailedCallbackIfError() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = nil
            let response: HTTPURLResponse? = nil
            let error: Error? = FakeResponseData.changeError
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(changeSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange (completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorData)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetChangeByProtocolShouldPostFailedCallbackIfNoData() {
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
        let changeService = ChangeService(changeSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange (completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorData)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetChangeByProtocolShouldPostFailedCallbackIfIncorrectResponse(){
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = FakeResponseData.changeIncorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseKO
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(changeSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange (completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorReponseCurrency)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    
    func testGetChangeByProtocolShouldPostFailedCallbackIfIncorrectData() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = FakeResponseData.changeIncorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(changeSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange (completionHandler:{ (success, error, current) in
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == Settings.shared.errorJson)
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testGetChangeByProtocolShouldPostSuccessCallbackIfCorrectResponseWithData() {
        URLProtocol.registerClass(FakeURLWithProtocol.self)
        // Given
        FakeURLWithProtocol.request = { request in
            let data: Data? = FakeResponseData.changeCorrectData
            let response: HTTPURLResponse? = FakeResponseData.responseOK
            let error: Error? = nil
            return (data, response, error)
        }
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [FakeURLWithProtocol.self]
        let session = URLSession(configuration: configuration)
        let changeService = ChangeService(changeSession: session)
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange (completionHandler:{ (success, error, current) in
        // Then
            XCTAssertTrue(success)
            XCTAssertNil(error)
            XCTAssert(current?.base == "EUR")
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }

}
