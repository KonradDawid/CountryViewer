//
//  Router.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation


enum Router {
    case countries(query: String)
    
    var path: URL {
        switch self {
        case .countries(let query):
            return URL(string: Constants.Endpoints.countries + (query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""))!
        }
    }
}

