//
//  HomeViewController.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 24/12/2020.
//

import UIKit
import RealmSwift

class HomeViewController: UIViewController {
    private lazy var contentView = HomeView(frame: self.view.frame)
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupButtonAction()
        setupPicker()
        setupPullToRefresh()
        getLatestRates()
    }
    
    private func setupView(){
        self.view = contentView
        self.overrideUserInterfaceStyle = .light
    }
        
    private func setupPicker(){
        self.contentView.pickerView.dataSource = self
        self.contentView.pickerView.delegate = self
    }
    
    private func setupButtonAction(){
        contentView.convertButton.addTarget(self, action: #selector(didPressConvertButton), for: .touchUpInside)
        
        contentView.didPressMidMarketButton = {
            self.showAlert(title: "Info", message: "Mid-market exchange rate at 13:38 UTC")
        }
    }
    
    private func setupPullToRefresh() {
        contentView.didPullToRefresh = {
            self.getLatestRates()
        }
    }
    
    private func getLatestRates(){
        viewModel.getLatestRates { (response) in
            self.contentView.refreshControl.endRefreshing()
            switch response {
            case .success(let latestRates):
                self.viewModel.handleResponse(data: latestRates)
                DispatchQueue.main.async {
                    self.contentView.pickerView.reloadAllComponents()
                }
            case .failure(let failure):
                self.showAlert(title: "Error", message: failure.localizedDescription)
            }
        }
    }

    @objc private func didPressConvertButton(){
        let baseCurrency = Double(self.contentView.baseCurrencyTextfield.text ?? "") ?? 0.0

        if viewModel.rate == 0.0 {
            showAlert(title: "Error", message: "Select the currency you want to convert to")
            return
        }else if baseCurrency == 0.0 {
            showAlert(title: "Error", message: "Enter a valid amount")
            return
        }else {
            let convertedCurrency = baseCurrency * viewModel.rate
            self.contentView.convertedTextfield.text = String(format: "%.2f", convertedCurrency)
        }
    }
}


extension HomeViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.viewModel.getRateList()?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.viewModel.getRateList()?[row].code
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 45
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data = self.viewModel.getRateList()?[row]
        self.viewModel.rate = data?.rate ?? 0.0
        self.viewModel.countryCode = data?.code ?? ""
        self.contentView.convertedTextfield.text = ""
        self.contentView.convertedTextfield.updateCurrencyTitle(currency: data?.code ?? "")
        self.contentView.toCountryView.countryImageImageView.image = UIImage(named: data?.code ?? "") ?? UIImage(named: "defaultflag")
        self.contentView.toCountryView.currencyLabel.text = data?.code
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let data = self.viewModel.getRateList()?[row]
        return PickerSelectionView(currencyCode: data?.code ?? "")
    }
}
