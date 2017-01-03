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


class FakeCountriesService: CountriesServiceProtocol {
    
    var searchText: String
    var json: JSON
    var callsCount: Int = 0
    
    init(json: JSON, forSearchText searchText: String) {
        self.json = json
        self.searchText = searchText
    }
    
    func getCountriesObservable(searchText: String) -> Observable<Result<[JSON]>> {
        callsCount += 1
        
        if searchText == self.searchText {
            let objects: [JSON] = json.array ?? []
            return Observable.just(.success(objects))
        } else {
            return Observable.just(.success([]))
        }
    }
}

