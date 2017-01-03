//
//  RequestBuilder.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import CoreData

class RequestBuilder {
    
    static func fetchRequest<T: Manageable>() -> NSFetchRequest<T> {
        return NSFetchRequest<T>(entityName: T.entityName())
    }
    
    static func fetchRequest<T: Manageable>(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> NSFetchRequest<T> {
        let fetchRequest: NSFetchRequest<T> = self.fetchRequest()
        
        if let predicate = predicate {
            fetchRequest.predicate = predicate
        }
        
        if let sortDescriptors = sortDescriptors, !sortDescriptors.isEmpty {
            fetchRequest.sortDescriptors = sortDescriptors
        }
        
        return fetchRequest
    }
}

// MARK: Predicates

extension NSPredicate {
    
    static func countryWithCode(code: Code) -> NSPredicate {
        return NSPredicate(format: "%K == %@", "code", code)
    }
    
    static func countriesWithCodes(codes: [Code]) -> NSPredicate {
        return NSPredicate(format: "%K IN %@", "code", codes)
    }
    
    static func countryWithNameAndCapital() -> NSPredicate {
        return NSPredicate(format: "name!=nil AND capital!=nil")
    }
    
    static func domainWithName(name: String) -> NSPredicate {
        return NSPredicate(format: "%K == %@", "name", name)
    }
    
    static func countryWithSearchtext(searchText: String) -> NSPredicate {
        return NSPredicate(format: "%K CONTAINS[cd] %@", "name", searchText)
    }
}

// MARK: Sort descriptors

extension NSSortDescriptor {
    
    static func countriesByName() -> NSSortDescriptor {
        return NSSortDescriptor(key: "name", ascending: true)
    }
}

