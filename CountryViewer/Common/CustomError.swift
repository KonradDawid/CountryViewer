//
//  CustomError.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation


enum CustomError: Error {
    case api
    case query
}

extension CustomError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .api:
            return "Try again"
        case .query:
            return "Enter country name"
        }
    }
}

