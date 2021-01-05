//
//  HomeView.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 24/12/2020.
//

import UIKit

class HomeView: UIView {
    
    var didPullToRefresh = {}
    var didPressMidMarketButton = {}
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func didPressDone() {
        pickerContainer.isHidden = true
    }
    
    @objc private func onPullToRefresh() {
        refreshControl.beginRefreshing()
        didPullToRefresh()
    }
    
    @objc private func onMidMarketButtonPress() {
        didPressMidMarketButton()
    }


    
    func showPicker() {
        pickerContainer.isHidden = false
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    
    let graphView = GraphView()


    let refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(onPullToRefresh), for: .valueChanged)
        return view
    }()

    
    let toolBar: UIToolbar = {
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didPressDone))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.translatesAutoresizingMaskIntoConstraints = false
        return toolBar
    }()
    
    lazy var pickerView: UIPickerView  = {
        let view = UIPickerView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var pickerContainer: UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerView)
        view.addSubview(toolBar)
        
        toolBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        toolBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        toolBar.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        toolBar.bottomAnchor.constraint(equalTo: self.pickerView.topAnchor).isActive = true

        pickerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        pickerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        return view
    }()
    
    
    private let signUpButton: UIButton = {
        let button = UIButton()
        button.contentHorizontalAlignment = .right
        button.titleLabel?.font = CustomFont.of(type: .semiBold, size: 16)
        button.setTitleColor(CustomColor.green, for: .normal)
        button.setTitle("Sign Up", for: .normal)
        return button
    }()
    
    private let hamburgerButton: UIButton = {
        let button = UIButton()
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "hamBurgerMenu"), for: .normal)
        return button
    }()
    
    private let currencyCalculatorLabel: UILabel = {
        let label = UILabel()
        label.font = CustomFont.of(type: .bold, size: 40)
        label.textColor = CustomColor.blue
        let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: "Currency\nCalculator.")
        attributedString.setColor(color: UIColor.green, forText: ".")
        label.attributedText = attributedString
        label.numberOfLines = 2
        return label
    }()
    
    let baseCurrencyTextfield: CustomTextfield = {
        let textfield = CustomTextfield(currency: "EUR")
        return textfield
    }()
    
    let convertedTextfield: CustomTextfield = {
        let textfield = CustomTextfield(currency: "")
        textfield.textColor = .black
        textfield.isUserInteractionEnabled = false
        return textfield
    }()
    
    
    let convertButton: UIButton = {
        let button = UIButton()
        button.setTitle("Convert", for: .normal)
        button.layer.cornerRadius = 4
        button.backgroundColor = CustomColor.green
        button.titleLabel?.font = CustomFont.of(type: .semiBold, size: 16)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let midMarketButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "infoButton"), for: .normal)
        button.setAttributedTitle(NSAttributedString(string: "Mid-market exchange rate at 13:38 UTC  ", attributes: [.underlineStyle: NSUnderlineStyle.styleSingle.rawValue, .font: UIFont.systemFont(ofSize: 14), .foregroundColor: CustomColor.blue ?? UIColor.blue]), for: .normal)
        button.setTitleColor(CustomColor.blue, for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.addTarget(self, action: #selector(onMidMarketButtonPress), for: .touchUpInside)
        return button
    }()
    
    private lazy var hStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.addArrangedSubview(hamburgerButton)
        stackView.addArrangedSubview(signUpButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    
    private lazy var countrySelectorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        stackView.addArrangedSubview(baseCountryView)
        stackView.addArrangedSubview(doubleArrowImageView)
        stackView.addArrangedSubview(toCountryView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let doubleArrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.init(systemName: "arrow.left.arrow.right")
        imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = .gray
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var baseCountryView: CountrySelectorView = {
        let view = CountrySelectorView()
        view.currencyLabel.text = "EUR"
        view.countryImageImageView.image = UIImage(named: "EUR")
        return view
    }()
    
    lazy var toCountryView: CountrySelectorView = {
        let view = CountrySelectorView()
        view.countryImageImageView.image = UIImage(named: "defaultflag")
        view.didPressView = {
            self.showPicker()
        }
        return view
    }()

    

    private lazy var vStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.addArrangedSubview(hStack)
        stackView.addArrangedSubview(currencyCalculatorLabel)
        stackView.addArrangedSubview(baseCurrencyTextfield)
        stackView.addArrangedSubview(convertedTextfield)
        stackView.addArrangedSubview(countrySelectorStackView)
        stackView.addArrangedSubview(convertButton)
        stackView.addArrangedSubview(midMarketButton)
        
        stackView.setCustomSpacing(60, after: hStack)
        stackView.setCustomSpacing(60, after: currencyCalculatorLabel)
        stackView.setCustomSpacing(20, after: baseCurrencyTextfield)
        stackView.setCustomSpacing(40, after: convertedTextfield)
        stackView.setCustomSpacing(40, after: convertButton)
        stackView.setCustomSpacing(40, after: countrySelectorStackView)
        stackView.setCustomSpacing(40, after: midMarketButton)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.refreshControl = refreshControl
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private func setupView(){
        self.backgroundColor = .white
        self.addSubview(scrollView)
        self.addSubview(pickerContainer)
        self.scrollView.addSubview(vStack)
        self.scrollView.addSubview(graphView)

        
        pickerContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        pickerContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        pickerContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        scrollView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        graphView.leftAnchor.constraint(equalTo: scrollView.leftAnchor).isActive = true
        graphView.rightAnchor.constraint(equalTo: scrollView.rightAnchor).isActive = true
        graphView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true

        
        vStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        vStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 30).isActive = true
        vStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -30).isActive = true
        vStack.bottomAnchor.constraint(equalTo: graphView.topAnchor, constant: -40).isActive = true
        vStack.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor, constant: -60).isActive = true
    }
}
