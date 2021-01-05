//
//  PickerSelectionView.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 04/01/2021.
//

import UIKit

class PickerSelectionView: UIView {
    
    init(currencyCode: String) {
        super.init(frame: .zero)
        setupView()
        countryImageImageView.image = UIImage(named: currencyCode)
        currencyLabel.text = currencyCode
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let countryImageImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(currencyLabel)
        stackView.addArrangedSubview(countryImageImageView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private func setupView(){
        self.addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
