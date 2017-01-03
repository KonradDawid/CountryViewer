//
//  CountriesProviderTests.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import XCTest
import Foundation
import RxSwift
@testable import CountryViewer

class CountriesProviderTests: TestCase {
    
    var sut: CountriesProvider!
    var persistenceManager: PersistenceManager!
    var fakeCountriesService: FakeCountriesService!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        sut = CountriesProvider()
        persistenceManager = PersistenceManager(managedObjectContext: TestManagedObjectContext.inMemoryManagedObjectContext())
        sut.persistenceManager = persistenceManager
        fakeCountriesService = FakeCountriesService(json: loadJson(.cam), forSearchText: "cam")
        sut.countriesService = fakeCountriesService
    }
    
    override func tearDown() {
        super.tearDown()
        
        fakeCountriesService = nil
        persistenceManager = nil
        sut = nil
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchingCountriesForCamQuery() {
        
        sut.reachabilityProvider = FakeReachabilityProvider(isConnected: true)
        
        let properCountriesCountExpectation = expectation(description: "proper countries count")
        let properServiceCallsCountExpectation = expectation(description: "proper service calls count")
        let properCountriesViewModelExpectation = expectation(description: "proper countryViewModel properties")
        
        sut.getCountriesObservable(searchText: "cam").subscribe(onNext: { (countriesResult) in
            if let countries = countriesResult.successValue {
                
                XCTAssertEqual(countries.count, 2)
                properCountriesCountExpectation.fulfill()
                
                XCTAssertEqual(self.fakeCountriesService.callsCount, 1)
                properServiceCallsCountExpectation.fulfill()
                
                let firstCountryViewModel = countriesResult.successValue?[0]
                XCTAssertEqual(firstCountryViewModel?.name, "Cambodia")
                XCTAssertEqual(firstCountryViewModel?.capital, "Phnom Penh")
                
                let secondCountryViewModel = countriesResult.successValue?[1]
                XCTAssertEqual(secondCountryViewModel?.name, "Cameroon")
                XCTAssertEqual(secondCountryViewModel?.capital, "Yaoundé")
                
                properCountriesViewModelExpectation.fulfill()
            }
        }).addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 1, handler:  { error in
            XCTAssertNil(error)
        })
    }
    
    func testOfflineFetchingCountriesForCamQuery() {
        
        _ = sut.getCountriesObservable(searchText: "cam").subscribe(onNext: { (result: Result<[CountryMO]>) in
            print("stubbed online data fetched and saved")
        }).addDisposableTo(disposeBag)
        
        sut.reachabilityProvider = FakeReachabilityProvider(isConnected: false)
        
        let properOfflineCountriesCountExpectation = expectation(description: "proper countries count")
        let properOfflineServiceCallsCountExpectation = expectation(description: "proper service calls count")
        let properOfflineCountriesViewModelExpectation = expectation(description: "proper countryViewModel properties")
        
        sut.getCountriesObservable(searchText: "cam").subscribe(onNext: { (countriesResult) in
            if let countries = countriesResult.successValue {
                
                XCTAssertEqual(countries.count, 2)
                properOfflineCountriesCountExpectation.fulfill()
                
                XCTAssertEqual(self.fakeCountriesService.callsCount, 1)
                properOfflineServiceCallsCountExpectation.fulfill()
                
                
                let firstCountryViewModel = countriesResult.successValue?[0]
                XCTAssertEqual(firstCountryViewModel?.name, "Cambodia")
                XCTAssertEqual(firstCountryViewModel?.capital, "Phnom Penh")
                
                let secondCountryViewModel = countriesResult.successValue?[1]
                XCTAssertEqual(secondCountryViewModel?.name, "Cameroon")
                XCTAssertEqual(secondCountryViewModel?.capital, "Yaoundé")
                
                properOfflineCountriesViewModelExpectation.fulfill()
            }
        }).addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 1, handler:  { error in
            XCTAssertNil(error)
        })
        
    }
}

