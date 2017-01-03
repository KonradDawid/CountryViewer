//
//  PersistenceManager.swift
//  CountryViewer
//
//  Created by Konrad on 03.01.2017.
//  Copyright © 2017 KonradDawid. All rights reserved.
//

import UIKit
import CoreData
import RxSwift


enum PersistenceError: Error {
    case empty
    case unkown
}

enum PersistenceSave {
    case ok
    case noChanges
}

protocol PersistenceManagerProtocol {
    func fetchArray<T: Manageable>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[T]>
    @discardableResult func save() -> Result<PersistenceSave>
    func fetchOrCreate<T: Manageable>(predicate: NSPredicate?) -> T
    var managedObjectContext: NSManagedObjectContext { get }
}

class PersistenceManager: PersistenceManagerProtocol {
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func fetchOrCreate<T: Manageable>(predicate: NSPredicate?) -> T {
        let fetchResult: Result<T> = fetch(predicate: predicate)
        switch fetchResult {
        case .success(let object):
            return object
        case .failure(_):
            return T.createInContext(managedObjectContext)
        }
    }
    
    func fetch<T: Manageable>(predicate: NSPredicate?) -> Result<T> {
        let request: NSFetchRequest<T> = RequestBuilder.fetchRequest(predicate: predicate, sortDescriptors: nil)
        let result = performRequest(request)
        
        if let error = result.failureValue {
            return .failure(error)
        }
        
        if let object = result.successValue?.first {
            return .success(object)
        } else {
            return .failure(PersistenceError.empty)
        }
    }
    
    func fetchArray<T: Manageable>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Result<[T]> {
        
        let request: NSFetchRequest<T> = RequestBuilder.fetchRequest(predicate: predicate, sortDescriptors: sortDescriptors)
        let result = performRequest(request)
        
        print("COUNT: \(T.entityName()) \(result.successValue?.count)")
        
        return result
    }
    
    func performRequest<T: Manageable>(_ request: NSFetchRequest<T>) -> Result<[T]> {
        do {
            let results = try managedObjectContext.fetch(request)
            return Result.success(results)
        } catch let error {
            print(error)
            return Result.failure(error)
        }
    }
    
    @discardableResult func save() -> Result<PersistenceSave> {
        guard managedObjectContext.hasChanges else {
            return .success(.noChanges)
        }
        
        do {
            try managedObjectContext.save()
            return .success(.ok)
        } catch let error {
            return .failure(error)
        }
    }
    
    
    // MARK: Dependencies
    
    var managedObjectContext: NSManagedObjectContext
}


extension PersistenceManagerProtocol {
    
    func observerForArray<T: Manageable>(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?) -> Observable<Result<[T]>> {
        
        // FIXME: simplified solution applied here
        
        return Observable.create { (observer: AnyObserver<Result<[T]>>) -> Disposable in
            
            let result: Result<[T]> = self.fetchArray(predicate: predicate, sortDescriptors: sortDescriptors)
            
            switch result {
            case .success(let objects):
                observer.onNext(.success(objects))
            case .failure(_):
                observer.onNext(Result.failure(PersistenceError.unkown))
            }
            observer.onCompleted()
            
            return Disposables.create()
        }
    }
}

