//
//  TestCase.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import XCTest
import SwiftyJSON


class TestCase: XCTestCase {
    
    enum JsonFile: String {
        case usa
        case germany
        case cam
    }
    
    func loadJson(_ jsonFile: JsonFile) -> JSON {
        let testBundle = Bundle(for: TestCase.self)
        let url = testBundle.url(forResource: jsonFile.rawValue, withExtension: "json")
        let data = try! Data(contentsOf: url!)
        return  JSON(data: data)
    }
}

