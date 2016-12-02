//
//  CountriesViewControllerTests.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import XCTest
import RxSwift
@testable import CountryViewer

class CountriesViewControllerTests: TestCase {
    
    var sut: CountriesViewController!
    
    override func setUp() {
        super.setUp()
        
        sut = CountriesViewController()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchingCountriesForUsaQuery() {
        
        sut.countriesViewModel.countriesService = FakeCountriesService(json: loadJson(.usa), forSearchText: "usa")
        sut.countriesViewModel.setupQueryObservable(Observable.just("usa"))
        _ = sut.view
        
        
        let properCountriesCountExpectation = expectation(description: "proper countries count")
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 1)
        properCountriesCountExpectation.fulfill()
        
        waitForExpectations(timeout: 1, handler:  { error in
            XCTAssertNil(error)
        })
    }
    
    func testFetchingCountriesForCamQuery() {
        
        sut.countriesViewModel.countriesService = FakeCountriesService(json: loadJson(.cam), forSearchText: "cam")
        sut.countriesViewModel.setupQueryObservable(Observable.just("cam"))
        _ = sut.view
        
        
        let properCountriesCountExpectation = expectation(description: "proper countries count")
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 3)
        properCountriesCountExpectation.fulfill()
        
        waitForExpectations(timeout: 1, handler:  { error in
            XCTAssertNil(error)
        })
    }
}

