//
//  CountriesViewController.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class CountriesViewController: UIViewController {
    
    // MARK: Properties
    
    let tableView = UITableView(frame: CGRect.zero)
    
    
    // MARK: Private properties
    
    private let disposeBag = DisposeBag()
    
    private let guideLabel = UILabel.styledLabel()
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar(frame: CGRect.zero)
        searchBar.placeholder = "Enter country name"
        return searchBar
    }()
    
    
    // MARK: Initializers
    
    init() {
        countriesViewModel.setupQueryObservable(searchBar.rx.text.asObservable())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        addSubviews()
        
        setupObservers()
        setupActions()
        
        setupLayout()
    }
    
    private func setupView() {
        title = "Country Search"
        edgesForExtendedLayout = UIRectEdge()
        view.backgroundColor = UIColor.white
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryTableViewCell.self, forCellReuseIdentifier: CountryTableViewCell.reuseIdentifier)
    }
    
    private func setupObservers() {
        countriesViewModel.updateObservable?.subscribe(onNext: { [weak self] (updateResult) in
            self?.tableView.reloadData()
            switch updateResult {
            case .success(let countriesCount):
                self?.guideLabel.text = "\(countriesCount)"
            case .failure(let error):
                self?.guideLabel.text = error.localizedDescription
            }
            }).addDisposableTo(disposeBag)
    }
    
    private func setupActions() {
        countriesViewModel.countrySelectionAction = { country in
            print("You selected: \(country)")
        }
    }
    
    private func addSubviews() {
        view.addSubview(searchBar)
        view.addSubview(guideLabel)
        view.addSubview(tableView)
    }
    
    
    // MARK: Layout
    
    private func setupLayout() {
        searchBar.snp.makeConstraints { (maker) in
            maker.height.equalTo(44)
            maker.top.equalTo(0)
            maker.left.right.equalTo(0)
        }
        
        guideLabel.snp.makeConstraints { (maker) in
            maker.top.equalTo(searchBar.snp.bottom)
            maker.height.equalTo(44)
            maker.centerX.equalTo(view.snp.centerX)
        }
        
        tableView.snp.makeConstraints { (maker) in
            maker.top.equalTo(guideLabel.snp.bottom)
            maker.left.right.bottom.equalTo(0)
        }
    }
    
    
    // MARK: Dependencies
    
    var countriesViewModel: CountriesViewModel = CountriesViewModel()
}

extension CountriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.numberOfCountries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CountryTableViewCell.reuseIdentifier) as! CountryTableViewCell
        configureCell(cell, forItemAtIndexPath: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: CountryTableViewCell, forItemAtIndexPath indexPath: IndexPath) {
        let countryViewModel = countriesViewModel.countryViewModel(atIndexPath: indexPath)
        cell.countryViewModel = countryViewModel
    }
}

extension CountriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        countriesViewModel.didSelectRowAt(indexPath)
    }
}

