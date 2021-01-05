//
//  CustomTabView.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 24/12/2020.
//

import UIKit

class CustomTabView: UIView {
    
    let thirtyDaysTab = CustomTabItemView(name: "Past 30 days", isActive: true)
    let ninetyDaysTab = CustomTabItemView(name: "Past 90 days", isActive: false)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupTapAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 20
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(thirtyDaysTab)
        stackView.addArrangedSubview(ninetyDaysTab)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    private func setupView(){
        self.addSubview(hStack)
        self.translatesAutoresizingMaskIntoConstraints = false
        hStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        hStack.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        hStack.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        hStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    private func setupTapAction(){
        thirtyDaysTab.onTapAction = {
            self.thirtyDaysTab.isActive = true
            self.ninetyDaysTab.isActive = false
        }
        
        ninetyDaysTab.onTapAction = {
            self.thirtyDaysTab.isActive = false
            self.ninetyDaysTab.isActive = true
        }

    }
}
