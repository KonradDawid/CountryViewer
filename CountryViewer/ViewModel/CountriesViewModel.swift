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
    
    lazy var countryButtonAction: CountryAction = { [weak self] country in
        print("You pressed button for: \(country.name)")
        print("BORDERS COUNT: \(country.borders?.count)")
        print("DOMAINS: \(country.domains?.count)")
        
        if let seto = country.borders {
            let set: Set<CountryMO> = seto as! Set<CountryMO>
            self?.borderCountries.value = set
        }
    }
    
    
    // MARK: Output properties
    
    var updateObservable: Observable<Result<Int>>?
    
    
    // MARK: Private properties
    
    private let countries = Variable<[CountryMO]>([])
    private let borderCountries = Variable<Set<CountryMO>>([])
    private let disposeBag = DisposeBag()
    
    // MARK: Observables
    
    func setupQueryObservable(_ queryObservable: Observable<String?>) {
        
        let countriesResultObservable = queryObservable
            .map({ $0 ?? "" })
            .map({ $0.trim() })
            .throttle(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { [weak self] query -> Observable<Result<[CountryMO]>> in
                guard !query.isEmpty else {
                    return Observable.just(.failure(CustomError.query))
                }
                return self?.countriesProvider.getCountriesObservable(searchText: query.trim()) ?? Observable.just(Result.success([]))
            }
            .shareReplay(1)
        
        countriesResultObservable.asObservable()
            .map { (result: Result<[CountryMO]>) in
                return result.successValue ?? []
            }.bindTo(countries)
            .addDisposableTo(disposeBag)
        
        let countriesCountObservable = countriesResultObservable.asObservable()
            .map { (result: Result<[CountryMO]>) in
                return result.map({ $0.count })
        }
        
        let borderCountriesObservable = borderCountries.asObservable()
        
        updateObservable = Observable.combineLatest(countriesCountObservable, borderCountriesObservable, resultSelector: { ($0, $1) })
            .map { (countriesTuple) -> Result<Int> in
                return countriesTuple.0
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
        let marked = borderCountries.value.contains(country)
        return CountryViewModel(country: country, marked: marked, buttonAction: { [weak self] in
            self?.countryButtonAction(country)
        })
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        guard countries.value.count > indexPath.row else { return }
        
        let country = countries.value[indexPath.row]
        countrySelectionAction?(country)
    }
    
    
    // MARK: Dependencies
    
    var countriesProvider: CountriesProviderProtocol = CountriesProvider()
}

