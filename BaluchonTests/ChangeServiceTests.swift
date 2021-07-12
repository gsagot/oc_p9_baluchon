//
//  ChangeServiceTests.swift
//  BaluchonTests
//
//  Created by Gilles Sagot on 06/07/2021.
//

import XCTest

@testable import Baluchon

class ChangeServiceTests: XCTestCase {

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
    
    func testGetTranslateShouldPostFailedCallbackIfError() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.changeError))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetTranslateShouldPostFailedCallbackIfNoData() {
        // Given
        let changeService = ChangeService(
            changeSession: URLSessionFake(data: nil, response: nil, error: nil))
            
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        changeService.getChange(completionHandler: { (success, error, current) in
            
        // Then
            XCTAssertFalse(success)
            XCTAssert(error == "Can't connect to the server, please verify your connexion")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }
    
    func testGetTranslateShouldPostFailedCallbackIfIncorrectResponse(){
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
            XCTAssert(error == "Can't connect to the server, please try again")
            XCTAssertNil(current)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
 
    }

}
