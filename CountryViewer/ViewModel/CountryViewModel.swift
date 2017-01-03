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
    let marked: Bool
    
    
    // MARK: Private properties
    
    fileprivate let country: CountryMO
    
    
    // MARK: Initializers
    
    init(country: CountryMO, marked: Bool, buttonAction: Action?) {
        self.country = country
        self.marked = marked
        self.buttonAction = buttonAction
    }
}

extension CountryViewModel {
    
    var name: String {
        return country.name ?? ""
    }
    
    var info: String {
        return "Capital: \((country.capital ?? ""))"
    }
}

