//
//  Country.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation
import SwiftyJSON


struct Country {
    let name: String
    let capital: String
    let topLevelDomains: [String]
}

extension Country: JsonInitiable {
    
    init?(json: JSON) {
        guard let name = json[Constants.Parsing.Country.nameKey].string else { return nil }
        
        self.name = name
        self.capital = json[Constants.Parsing.Country.captialKey].stringValue
        
        let tlds = json[Constants.Parsing.Country.topLevelDomainKey].arrayValue
        self.topLevelDomains = tlds.flatMap { $0.string }
    }
}

extension Country: CustomStringConvertible {
    
    var description: String {
        return "\(name) : \(capital) : \(topLevelDomains)"
    }
}

