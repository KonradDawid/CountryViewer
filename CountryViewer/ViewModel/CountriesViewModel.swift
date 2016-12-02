//
//  CountriesViewModel.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import Foundation
import RxSwift


class CountriesViewModel {
    
    // MARK: Input properties
    
    var countrySelectionAction: CountryAction?
    var countryButtonAction: CountryAction = { country in
        print("You pressed button for: \(country)")
    }
    
    
    // MARK: Output properties
    
    var updateObservable: Observable<Result<Int>>?
    
    
    // MARK: Private properties
    
    private let countries = Variable<[Country]>([])
    private let disposeBag = DisposeBag()
    
    // MARK: Observables
    
    func setupQueryObservable(_ queryObservable: Observable<String?>) {
        
        let countriesResultObservable = queryObservable
            .map({ $0 ?? "" })
            .map({ $0.trim() })
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<Result<[Country]>> in
                guard !query.isEmpty else {
                    return Observable.just(.failure(CustomError.query))
                }
                return self?.countriesService.getCountriesObservable(searchText: query.trim()) ?? Observable.just(Result.success([]))
            }
            .shareReplay(1)
        
        countriesResultObservable.asObservable()
            .map { (result: Result<[Country]>) in
                return result.successValue ?? []
            }.bindTo(countries)
            .addDisposableTo(disposeBag)
        
        updateObservable = countriesResultObservable.asObservable()
            .map { (result: Result<[Country]>) in
                return result.map({ $0.count })
            }
            .observeOn(MainScheduler.instance)
    }
    
    // MARK: Data methods
    
    func numberOfCountries() -> Int {
        return countries.value.count
    }
    
    func countryViewModel(atIndexPath indexPath: IndexPath) -> CountryViewModel? {
        guard countries.value.count > indexPath.row else { return nil }
        
        let country = countries.value[indexPath.row]
        return CountryViewModel(country: country, buttonAction: { [weak self] in
            self?.countryButtonAction(country)
            })
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard countries.value.count > indexPath.row else { return }
        
        let country = countries.value[indexPath.row]
        countrySelectionAction?(country)
    }
    
    // MARK: Dependencies
    
    var countriesService: CountriesServiceProtocol = CountriesService()
}

