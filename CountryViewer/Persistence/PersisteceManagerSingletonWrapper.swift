//
//  PersisteceManagerSingletonWrapper.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation


class PersistenceManagerSingletonWrapper {
    
    static let sharedInstance = PersistenceManagerSingletonWrapper()
    
    let persistenceManager = PersistenceManager(managedObjectContext: PersistenceStack().managedObjectContext)
    
    private init() {}
}

