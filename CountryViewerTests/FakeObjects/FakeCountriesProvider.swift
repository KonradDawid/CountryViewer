//
//  FakeCountriesProvider.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON
@testable import CountryViewer

class FakeCountriesProvider: CountriesProviderProtocol {
    
    var searchText: String
    var json: JSON
    
    private let persistenceManager: PersistenceManagerProtocol
    
    init(json: JSON, forSearchText searchText: String, persistenceManager: PersistenceManagerProtocol) {
        self.json = json
        self.searchText = searchText
        self.persistenceManager = persistenceManager
    }
    
    func getCountriesObservable(searchText: String) -> Observable<Result<[CountryMO]>> {
        guard searchText == self.searchText else {
            return Observable.just(.success([]))
        }
        
        return Observable.just(.success(CountryMO.arrayFromJson(jsonArray: json.array ?? [], persistenceManager: persistenceManager)))
    }
}


