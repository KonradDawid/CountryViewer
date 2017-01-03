//
//  CountriesVewModelTests.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import XCTest
import RxSwift
@testable import CountryViewer

class CountriesViewModelTests: TestCase {
    
    var sut: CountriesViewModel!
    var fakeCountriesProvider: FakeCountriesProvider!
    var persistenceManager: PersistenceManagerProtocol!
    var disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        
        persistenceManager = PersistenceManager(managedObjectContext: TestManagedObjectContext.inMemoryManagedObjectContext())
        fakeCountriesProvider = FakeCountriesProvider(json: loadJson(.usa), forSearchText: "USA", persistenceManager: persistenceManager)
        sut = CountriesViewModel()
        sut.countriesProvider = fakeCountriesProvider
        sut.setupQueryObservable(Observable.just("USA"))
    }
    
    override func tearDown() {
        super.tearDown()
        
        persistenceManager = nil
        fakeCountriesProvider = nil
        sut = nil
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testFetchingCountry() {
        
        let properCountriesCountExpectation = expectation(description: "proper countries count")
        let properCountryViewModelExpectation = expectation(description: "proper countryViewModel properties")
        
        sut.updateObservable?.subscribe(onNext: { (update) in
            if let countriesCount = update.successValue {
                
                XCTAssertEqual(countriesCount, 1)
                properCountriesCountExpectation.fulfill()
                
                let countryViewModel = self.sut.countryViewModel(atIndexPath: IndexPath(row: 0, section: 0))
                XCTAssertEqual(countryViewModel?.name, "United States")
                XCTAssertEqual(countryViewModel?.info, "Capital: Washington, D.C.")
                properCountryViewModelExpectation.fulfill()
            }
        }).addDisposableTo(disposeBag)
        
        waitForExpectations(timeout: 1, handler:  { error in
            XCTAssertNil(error)
        })
    }
}

