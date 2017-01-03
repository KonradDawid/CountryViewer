//
//  Manageable.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import CoreData


protocol Manageable: NSFetchRequestResult {}

extension Manageable {
    
    static func entityName() -> String {
        return String(describing: self)
    }
}

extension Manageable {
    
    static func createInContext<T>(_ mangedObjectContext: NSManagedObjectContext) -> T {
        let object = NSEntityDescription.insertNewObject(forEntityName: entityName(), into: mangedObjectContext)
        return object as! T
    }
}

