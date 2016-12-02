//
//  CountryViewModel.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation


struct CountryViewModel {
    
    // MARK: Properties
    
    let buttonAction: Action?
    
    
    // MARK: Private properties
    
    fileprivate let country: Country
    
    
    // MARK: Initializers
    
    init(country: Country, buttonAction: Action?) {
        self.country = country
        self.buttonAction = buttonAction
    }
}

extension CountryViewModel {
    
    var name: String {
        return country.name
    }
    
    var info: String {
        return "Capital: \(country.capital), domains: \(country.topLevelDomains.joined(separator: " "))"
    }
}

