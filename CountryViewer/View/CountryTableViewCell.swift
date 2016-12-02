//
//  CountryTableViewCell.swift
//  CountryViewer
//
//  Created by Konrad on 02.12.2016.
//  Copyright © 2016 KonradDawid. All rights reserved.
//

import UIKit
import SnapKit

class CountryTableViewCell: UITableViewCell {
    
    // MARK: Properties
    
    var countryViewModel: CountryViewModel? {
        didSet {
            nameLabel.text = countryViewModel?.name
            infoLabel.text = countryViewModel?.info
            buttonAction = countryViewModel?.buttonAction
        }
    }
    
    
    // MARK: Private properties
    
    private var buttonAction: Action?
    
    private let nameLabel: UILabel = UILabel.styledLabel(weight: .bold)
    private let infoLabel: UILabel = UILabel.styledLabel(weight: .light)
    private let actionButton: UIButton = {
        let button = UIButton.withStyle(.warning)
        button.setTitle("click!", for: .normal)
        return button
    }()
    
    
    // MARK: Initializer
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureSelf()
        addSubviews()
        setupLayout()
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureSelf() {
        selectionStyle = .none
    }
    
    private func addSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(actionButton)
    }
    
    private func configureButton() {
        actionButton.addTarget(self, action: #selector(CountryTableViewCell.actionButtonTapped), for: .touchUpInside)
    }
    
    func actionButtonTapped() {
        buttonAction?()
    }
    
    
    // MARK: Layout
    
    private func setupLayout() {
        nameLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.right.equalTo(actionButton.snp.left).offset(-10)
            maker.top.equalTo(0)
        }
        
        infoLabel.snp.makeConstraints { (maker) in
            maker.left.equalTo(20)
            maker.right.equalTo(actionButton.snp.left).offset(-10)
            maker.top.equalTo(nameLabel.snp.bottom)
        }
        
        actionButton.snp.makeConstraints { (maker) in
            maker.right.equalTo(contentView.snp.right).offset(-10)
            maker.top.equalTo(contentView.snp.top).offset(10)
            maker.bottom.equalTo(contentView.snp.bottom).offset(-10)
            maker.width.equalTo(88)
        }
    }
    
    
    // MARK: Reuse
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        infoLabel.text = nil
    }
}

