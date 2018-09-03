//
//  LogoServiceTestCase.swift
//  LogoViewerTests
//
//  Created by Mickael on 03/09/2018.
//  Copyright © 2018 OpenClassrooms. All rights reserved.
//

@testable import LogoViewer
import XCTest

class LogoServiceTestCase: XCTestCase {
    
    func testGetLogoShouldPostFailedCallbackIfNoPictureData() {
        
        // Given
        let logoService = LogoService(session: URLSessionFake(data: nil, response: nil, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        logoService.getLogo(domain: "openclassrooms.com") { (success, logo) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldPostFailedCallbackIfError() {
        
        // Given
        let logoService = LogoService(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData().error))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        logoService.getLogo(domain: "openclassrooms.com") { (success, logo) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldPostFailedCallbackIfIncorrectResponse() {
        
        // Given
        let logoService = LogoService(session: URLSessionFake(data: nil, response: FakeResponseData().responseKO, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        logoService.getLogo(domain: "openclassrooms.com") { (success, logo) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(logo)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
    
    func testGetLogoShouldPostSuccessCallbackIfNoErrorAndCorrectResponse(){
        
        // Given
        let logoService = LogoService(session: URLSessionFake(data: FakeResponseData().imageData, response: FakeResponseData().responseOK, error: nil))
        
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change")
        logoService.getLogo(domain: "openclassrooms.com") { (success, logo) in
            // Then
            let imageData = "image".data(using: .utf8)!
            XCTAssertTrue(success)
            XCTAssertEqual(imageData, logo!)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.01)
    }
}
