//
//  ChallengeUITests.swift
//  ChallengeUITests
//
//  Created by Lucas Henrique Machado da Silva on 08/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import XCTest
@testable import Challenge

class ChallengeUITests: XCTestCase {
    // MARK: - Variables
    var application: XCUIApplication?
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        self.application = XCUIApplication()
        guard let _ = self.application else {
            XCTFail("Error: Failed to load application.")
            return
        }
        
        self.application?.launch()
    }
    
    override func tearDown() {
        self.application = nil
        
        super.tearDown()
    }
    
    // MARK: - UITests
    func testChallenge() {
        guard let application = self.application else {
            XCTFail("Error: No application loaded.")
            return
        }
        
        let loopTest = 5
        let swipeCount = 10
        
        for _ in 0..<Int(arc4random_uniform(UInt32(loopTest))) {
            for _ in 0..<Int(arc4random_uniform(UInt32(swipeCount))) {
                application.swipeUp()
            }
            
            let tableView = application.tables["tvMovies"]
            let cells = tableView.cells
            let random = Int(arc4random_uniform(UInt32(cells.count)))
            if (cells.element(boundBy: random).exists) {
                cells.element(boundBy: random).tap()
            } else {
                XCTFail("Error: Cell missing.")
            }
            
            application.navigationBars.buttons.element(boundBy: 0).tap()
        }
    }
}
