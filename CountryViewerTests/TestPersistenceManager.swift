//
//  TestPersistenceManager.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import CoreData

class TestManagedObjectContext {
    
    static func inMemoryManagedObjectContext() -> NSManagedObjectContext {
        let modelURL = Bundle.main.url(forResource: "CountryViewer", withExtension: "momd")!
        let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        
        do {
            try coordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("Could not add in-memory persistent store to coordinator")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }
}

