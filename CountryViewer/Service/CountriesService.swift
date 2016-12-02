//
//  CountriesService.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON


protocol CountriesServiceProtocol {
    func getCountriesObservable(searchText: String) -> Observable<Result<[Country]>>
}

struct CountriesService: CountriesServiceProtocol {
    
    func getCountriesObservable(searchText: String) -> Observable<Result<[Country]>> {
        return observerForArray(sessionManager: sessionManager, path: Router.countries(query: searchText).path)
    }
    
    // MARK: Dependencies
    
    var sessionManager: SessionManager = SessionManager.default
}

func observerForArray<T: JsonInitiable>(sessionManager: SessionManager, path: URLConvertible) -> Observable<Result<[T]>> {
    
    return Observable.create { (observer: AnyObserver<Result<[T]>>) -> Disposable in
        let request = sessionManager.request(path, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).validate().responseJSON { (response) -> () in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let objects: [T] = T.arrayFromJson(json)
                observer.onNext(.success(objects))
            case .failure(_):
                observer.onNext(.failure(CustomError.api))
            }
            observer.onCompleted()
        }
        
        return Disposables.create {
            request.cancel()
        }
    }
}

