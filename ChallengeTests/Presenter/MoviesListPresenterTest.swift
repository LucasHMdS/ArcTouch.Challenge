//
//  MoviesListPresenterTest.swift
//  MoviesListPresenterTest
//
//  Created by Lucas Henrique Machado da Silva on 08/05/2018.
//  Copyright © 2018 Lucas Henrique Machado da Silva. All rights reserved.
//

import XCTest
@testable import Challenge

class MoviesListPresenterTest: XCTestCase {
    // MARK: - Presenter
    var presenter: MoviesListPresenter?
    
    // MARK: - Constants
    let localTimeout = 20.0
    let globalTimeout = 150.0
    
    // MARK: - Variables
    var setExpectation: XCTestExpectation?
    var reloadExpectation: XCTestExpectation?
    var addExpectation: XCTestExpectation?
    var expectationsArray: [XCTestExpectation]?
    
    // MARK: - Test Lifecycle
    override func setUp() {
        super.setUp()
        
        self.presenter = MoviesListPresenter(self)
        self.expectationsArray = [XCTestExpectation]()
        
        self.setExpectation = XCTestExpectation(description: "Interaction with set movies.")
        self.expectationsArray?.append(self.setExpectation!)
        
        self.reloadExpectation = XCTestExpectation(description: "Interaction with reload movies.")
        self.expectationsArray?.append(self.reloadExpectation!)
        
        self.addExpectation = XCTestExpectation(description: "Interaction with add movies.")
        self.expectationsArray?.append(self.addExpectation!)
    }
    
    override func tearDown() {
        self.expectationsArray = nil
        self.setExpectation = nil
        self.reloadExpectation = nil
        self.addExpectation = nil
        self.presenter = nil
        
        super.tearDown()
    }
    
    // MARK: - Tests
    func testPresenter() {
        guard let _ = self.presenter else {
            XCTFail("Error: Presenter not found.")
            return
        }
        
        guard let _ = self.expectationsArray else {
            XCTFail("Error: Expectations array not found.")
            return
        }
        
        self.presenter?.getUpcomingMovies()
        DispatchQueue.main.asyncAfter(deadline: .now() + self.localTimeout) {
            self.presenter?.reloadAllMovies()
            DispatchQueue.main.asyncAfter(deadline: .now() + self.localTimeout) {
                self.presenter?.getUpcomingMovies()
                DispatchQueue.main.asyncAfter(deadline: .now() + self.localTimeout) {
                    self.presenter?.getUpcomingMovies()
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.localTimeout) {
                        self.presenter?.filterBySearch("a")
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.localTimeout) {
                            self.presenter?.filterBySearch("")
                        }
                    }
                }
            }
        }
        
        wait(for: self.expectationsArray!, timeout: self.globalTimeout)
    }
}

extension MoviesListPresenterTest: MoviesListPresenterDelegate {
    func setMovies(_ movies: [Movie]) {
        self.setExpectation?.fulfill()
    }
    
    func noMovies(message: String, last: Bool) {
        XCTFail("Error: \(message)")
    }
    
    func reloadMovies(_ movies: [Movie]) {
        self.reloadExpectation?.fulfill()
    }
    
    func displayError(message: String) {
        XCTFail("Error: \(message)")
    }
    
    func addMovies(_ movies: [Movie], last: Bool) {
        self.addExpectation?.fulfill()
    }
}
