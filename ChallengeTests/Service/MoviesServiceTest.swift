//
//  MoviesServiceTest.swift
//  MoviesServiceTest
//
//  Created by Lucas Henrique Machado da Silva on 08/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import XCTest
@testable import Challenge

class MoviesServiceTest: XCTestCase {
    // MARK: - Constants
    let timeout = 30.0
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests
    func testGetUpcoming() {
        let expectation = XCTestExpectation(description: "Get TMDb upcoming movies.")
        
        MoviesService.getUpcoming() {
            (upcomingMovieDTO, error) in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if let _ = upcomingMovieDTO {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: self.timeout)
    }
}
