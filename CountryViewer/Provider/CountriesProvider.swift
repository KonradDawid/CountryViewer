//
//  CountriesProvider.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON


protocol CountriesProviderProtocol {
    func getCountriesObservable(searchText: String) -> Observable<Result<[CountryMO]>>
}

class CountriesProvider: CountriesProviderProtocol {
    
    func getCountriesObservable(searchText: String) -> Observable<Result<[CountryMO]>> {
        
        if reachabilityProvider.isConnected {
            return countriesService.getCountriesObservable(searchText: searchText)
                .map({ (result: Result<[JSON]>) -> Result<[CountryMO]> in
                    result.map({ (jsonArray) -> [CountryMO] in
                        return CountryMO.arrayFromJson(jsonArray: jsonArray, persistenceManager: self.persistenceManager)
                    })
                })
                .do(onNext: { (_) in
                    self.persistenceManager.save()
                })
        } else {
            let searchTextPredicate = NSPredicate.countryWithSearchtext(searchText: searchText)
            let sortDescriptor = NSSortDescriptor.countriesByName()
            let countriesMOObservable: Observable<Result<[CountryMO]>> = persistenceManager.observerForArray(predicate: searchTextPredicate, sortDescriptors: [sortDescriptor])
            return countriesMOObservable
        }
    }
    
    
    // MARK: Dependencies
    
    var reachabilityProvider: ReachabilityProviderProtocol = ReachabilityProvider()
    var persistenceManager: PersistenceManagerProtocol = PersistenceManagerSingletonWrapper.sharedInstance.persistenceManager
    var countriesService: CountriesServiceProtocol = CountriesService()
}

