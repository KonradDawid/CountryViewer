//
//  PersistenceStack.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import Foundation
import CoreData


protocol PersistenceStackProtocol {
    var managedObjectContext: NSManagedObjectContext { get }
}

class PersistenceStack: PersistenceStackProtocol {
    
    private let managedObjectModelFileName = "CountryViewer"
    private let managedObjectModelFileExtension = "momd"
    private let sqliteFileName = "CountryViewer.sqlite"
    
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.endIndex-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: self.managedObjectModelFileName, withExtension: self.managedObjectModelFileExtension)!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent(self.sqliteFileName)
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            print("Could not add sqlite persistent store to coordinator")
        }
        return coordinator
    }()
}

