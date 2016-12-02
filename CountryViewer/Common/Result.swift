//
//  Result.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation


enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    
    func map<U>(_ transform: @escaping (T) -> U) -> Result<U> {
        switch self {
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
}

extension Result {
    
    var successValue: T? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
    
    var failureValue: Error? {
        switch self {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
}

