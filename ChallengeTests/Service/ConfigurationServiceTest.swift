//
//  ConfigurationServiceTest.swift
//  ConfigurationServiceTest
//
//  Created by Lucas Henrique Machado da Silva on 08/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import XCTest
@testable import Challenge

class ConfigurationServiceTest: XCTestCase {
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
    func testGetConfiguration() {
        let expectation = XCTestExpectation(description: "Get TMDb configurations.")
        
        ConfigurationService.getConfiguration() {
            (configurationDTO, error) in
            
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
            } else if let _ = configurationDTO {
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: self.timeout)
    }
}
