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
    var persistenceManager: PersistenceManager!
    
    override func setUp() {
        super.setUp()
        
        persistenceManager = PersistenceManager(managedObjectContext: TestManagedObjectContext.inMemoryManagedObjectContext())
        sut = CountriesViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        
        persistenceManager = nil
        sut = nil
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchingCountriesForUsaQuery() {
        
        sut.countriesViewModel.countriesProvider = FakeCountriesProvider(json: loadJson(.usa), forSearchText: "usa", persistenceManager: persistenceManager)
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
        
        sut.countriesViewModel.countriesProvider = FakeCountriesProvider(json: loadJson(.cam), forSearchText: "cam", persistenceManager: persistenceManager)
        sut.countriesViewModel.setupQueryObservable(Observable.just("cam"))
        _ = sut.view
        
        let properCountriesCountExpectation = expectation(description: "proper countries count")
        
        XCTAssertEqual(sut.tableView.numberOfRows(inSection: 0), 2)
        properCountriesCountExpectation.fulfill()
        
        waitForExpectations(timeout: 1, handler:  { error in
            XCTAssertNil(error)
        })
    }
}


