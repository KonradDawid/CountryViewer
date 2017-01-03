//
//  CountryViewModelTests.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import XCTest
@testable import CountryViewer

class CountryViewModelTests: TestCase {
    
    var sut: CountryViewModel!
    var persistenceManager: PersistenceManager!
    
    override func setUp() {
        super.setUp()
        
        persistenceManager = PersistenceManager(managedObjectContext: TestManagedObjectContext.inMemoryManagedObjectContext())
        let country: CountryMO = CountryMO.createInContext(persistenceManager.managedObjectContext)
        country.setupWithJson(json: loadJson(.germany), persistenceManager: persistenceManager)
        sut = CountryViewModel(country: country, marked: false, buttonAction: nil)
    }
    
    override func tearDown() {
        super.tearDown()
        
        persistenceManager = nil
        sut = nil
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testNameExtension() {
        XCTAssertEqual(sut.name, "Germany")
    }
    
    func testInfoExtension() {
        XCTAssertEqual(sut.info, "Capital: Berlin")
    }
}

