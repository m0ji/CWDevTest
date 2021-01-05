//
//  HomeViewModel.swift
//  CWDevTest
//
//  Created by Mojisola Adebiyi on 04/01/2021.
//

import Foundation
import RealmSwift
import SwiftyJSON

class HomeViewModel {
    var countryCode = ""
    var rate = 0.0
    private let converterService = LatestRateService()
    
    func getLatestRates(completionHandler: @escaping (Result<JSON, Error>) -> ()){
        converterService.latestRates(completionHandler: completionHandler)
    }
    
    private func convertRatesStringToArray(rate: String?) -> [String] {
        guard let newString = rate else { return [] }
        var str = newString
        str = str.replacingOccurrences(of: "{", with: "").replacingOccurrences(of: "}", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "\"", with: "")
        
        let arry = str.split(separator: ",")
        
        var newArray = [String]()
        for obj in arry {
            let item = obj.replacingOccurrences(of: ":", with: "").trimmingCharacters(in: .newlines)
            newArray.append(String(item))
        }
        return newArray
    }

    
    private func convertRatesArrayToRealmObject(data: [String]) -> List<CurrencyRate> {
        var tempRates = List<CurrencyRate>()
        for item in data {
            if let rateValue =  Double("\(item.suffix(from: item.index(item.startIndex, offsetBy: 3)))") {
                let temp = CurrencyRate()
                temp.code = "\(item.prefix(3))"
                temp.rate = rateValue
                tempRates.append(temp)
            }
        }
        
        return tempRates
    }
    
    private func saveRatesArrayToDB(data: List<CurrencyRate>) -> RateList {
        let ratesList = RateList()
        ratesList.rates = data
        
        let realm = try! Realm()
        let tt = realm.objects(RateList.self)

        try! realm.write {
            realm.delete(tt)
            realm.add(ratesList)
        }
        
        return ratesList
    }
    
    @discardableResult
    func handleResponse(data: JSON) -> RateList {
        let rateString = data["rates"].rawString()
        let array = convertRatesStringToArray(rate: rateString)
        let realmObj = convertRatesArrayToRealmObject(data: array)
        return saveRatesArrayToDB(data: realmObj)
    }

    
    func getRateList() -> [CurrencyRate]? {
        let realm = try! Realm()
        return realm.objects(RateList.self).first?.rates.sorted(by: { (a, b) -> Bool in
            return a.code < b.code
        })
    }
}
