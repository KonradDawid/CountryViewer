//
//  Constants.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import UIKit


struct Constants {
    
    struct Style {
        static let defaultTextColor = UIColor.black
        static let warningTextColor = UIColor.red
        static let defaultButtonColor = UIColor.lightGray
        static let warningButtonColor = UIColor.orange
        static let defaultBorderColor = UIColor.darkGray
        static let warningBorderColor = UIColor.red
    }
    
    struct Endpoints {
        static let countries = "https://restcountries.eu/rest/v1/name/"
    }
    
    struct Parsing {
        struct Country {
            static let nameKey = "name"
            static let captialKey = "capital"
            static let topLevelDomainKey = "topLevelDomain"
        }
    }
}

