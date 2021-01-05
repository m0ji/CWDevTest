//
//  CustomTabItemView.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 24/12/2020.
//

import UIKit

class CustomTabItemView: UIView {
    var onTapAction = {}
    var activeColor = CustomColor.green
    
    var isActive: Bool = false {
        didSet(value) {
            activeView.backgroundColor = isActive ? activeColor : UIColor.clear
            title.textColor = isActive ? .white : UIColor.white.withAlphaComponent(0.3)
        }
    }

    init(name: String, isActive: Bool = false) {
        super.init(frame: .zero)
        self.isActive = isActive
        self.title.text = name
        setupView()
        setupTapAction()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = CustomFont.of(type: .medium, size: 16)
        label.textColor = self.isActive ? .white : UIColor.white.withAlphaComponent(0.3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activeView: UIView = {
        let view = UIView()
        view.backgroundColor = isActive ? activeColor : UIColor.clear
        view.heightAnchor.constraint(equalToConstant: 10).isActive = true
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupTapAction(){
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))
    }
    
    @objc private func onTap() {
        onTapAction()
    }
    
    
    private func setupView(){
        self.isUserInteractionEnabled = true
        self.addSubview(title)
        self.addSubview(activeView)
        
        self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.activeView.topAnchor.constraint(equalTo: self.title.bottomAnchor, constant: 5).isActive = true
        self.activeView.centerXAnchor.constraint(equalTo: self.title.centerXAnchor, constant: 0).isActive = true
        self.activeView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
