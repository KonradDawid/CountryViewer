//
//  FakeCountriesService.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import XCTest
import RxSwift
import SwiftyJSON
@testable import CountryViewer


struct FakeCountriesService: CountriesServiceProtocol {
    
    var searchText: String
    var json: JSON
    
    init(json: JSON, forSearchText searchText: String) {
        self.json = json
        self.searchText = searchText
    }
    
    func getCountriesObservable(searchText: String) -> Observable<Result<[Country]>> {
        if searchText == self.searchText {
            return Observable.just(.success(Country.arrayFromJson(json)))
        } else {
            return Observable.just(.success([]))
        }
    }
}

