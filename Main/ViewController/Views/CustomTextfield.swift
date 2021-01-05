//
//  CustomTextfield.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 26/12/2020.
//

import UIKit

class CustomTextfield: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)

    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = UIColor.gray.withAlphaComponent(0.5)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.heightAnchor.constraint(equalToConstant: 80).isActive = true
        label.widthAnchor.constraint(equalToConstant: 80).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(currency: String) {
        super.init(frame: .zero)
        setupView()
        currencyLabel.text = currency
    }
    

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.backgroundColor = CustomColor.textfieldGray
        self.layer.cornerRadius = 4
        self.textColor = .black
        self.rightViewMode = .always
        self.rightView = currencyLabel
        self.keyboardType = .numberPad
        self.font = CustomFont.of(type: .medium, size: 20)
    }
    
    func updateCurrencyTitle(currency: String){
        currencyLabel.text = currency
    }
}
