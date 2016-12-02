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
    
    override func setUp() {
        super.setUp()
        
        sut = CountryViewModel(country: Country(json: loadJson(.germany))!, buttonAction: nil)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialization() {
        XCTAssertNotNil(sut)
    }
    
    func testNameExtension() {
        XCTAssertEqual(sut.name, "Germany")
    }
    
    func testInfoExtension() {
        XCTAssertEqual(sut.info, "Capital: Berlin, domains: .de")
    }
}

