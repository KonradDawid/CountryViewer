//
//  CountryMO+CoreDataClass.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


public class CountryMO: NSManagedObject {

}

extension CountryMO: Manageable { }

extension CountryMO {
    
    func setupWithJson(json: JSON, persistenceManager: PersistenceManagerProtocol) {
        guard !self.completed else {
            return
        }
        
        if let code = json[Constants.Parsing.Country.codeKey].string {
            self.code = code
        }
        
        if let name = json[Constants.Parsing.Country.nameKey].string {
            self.name = name
        }
        
        if let capital = json[Constants.Parsing.Country.captialKey].string {
            self.capital = capital
        }
        
        let borders = json[Constants.Parsing.Country.bordersKey].arrayValue
        if !borders.isEmpty {
            let borderCountries =  borders.flatMap { (borderCountryJson) -> CountryMO?  in
                guard let borderCode = borderCountryJson.string else { return nil }
                let borderCountryPredicate = NSPredicate.countryWithCode(code: borderCode)
                let borderCountry: CountryMO = persistenceManager.fetchOrCreate(predicate: borderCountryPredicate)
                if borderCountry.code == nil { borderCountry.code = borderCode }
                return borderCountry
            }
            self.addToBorders(NSSet(array: borderCountries))
        }
        
        let topLevelDomains = json[Constants.Parsing.Country.topLevelDomainKey].arrayValue
        if !topLevelDomains.isEmpty {
            let domains = topLevelDomains.flatMap { (domainJson) -> DomainMO? in
                guard let domainName = domainJson.string else { return nil }
                let domainPredicate = NSPredicate.domainWithName(name: domainName)
                let domain: DomainMO = persistenceManager.fetchOrCreate(predicate: domainPredicate)
                if domain.name == nil { domain.name = domainName }
                return domain
            }
            self.addToDomains(NSSet(array: domains))
        }
        
        self.completed = true
    }
}

extension CountryMO {
    
    static func arrayFromJson(jsonArray: [JSON], persistenceManager: PersistenceManagerProtocol) -> [CountryMO] {
        return jsonArray.flatMap({ (json) -> CountryMO? in
            guard let code = json[Constants.Parsing.Country.codeKey].string else { return nil }
            let codePredicate = NSPredicate.countryWithCode(code: code)
            let countryMO: CountryMO = persistenceManager.fetchOrCreate(predicate: codePredicate)
            countryMO.setupWithJson(json: json, persistenceManager: persistenceManager)
            return countryMO
        })
    }
}

